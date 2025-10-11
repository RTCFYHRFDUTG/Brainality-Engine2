package;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.addons.transition.FlxTransitionableState;
import flixel.effects.FlxFlicker;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
////import io.newgrounds.NG;
import lime.app.Application;
import flixel.util.FlxTimer;
//import states.options.OptionsMenu;
import states.options.PlaceholderOptionsState;
import hxvlc.flixel.FlxVideoSprite;
import EditorMenuSubState;
using StringTools;

class MainMenuState extends MusicBeatState
{
	var curSelected:Int = 0;
	var inEditor:Bool = false;
	var menuItems:FlxTypedGroup<FlxSprite>;
    var stat = new FlxVideoSprite(320, 180);

	public static var version = '0.0.1';

	var optionShit:Array<String> = ['story mode', 'freeplay', 'mods', 'options'];
	
	var magenta:FlxSprite;
	var camFollow:FlxObject;

	override function create()
	{
		transIn = FlxTransitionableState.defaultTransIn;
		transOut = FlxTransitionableState.defaultTransOut;

		if (!FlxG.sound.music.playing)
		{
			FlxG.sound.playMusic('assets/music/freakyMenu' + TitleState.soundExt);
		}

		persistentUpdate = persistentDraw = true;

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuBG.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		camFollow = new FlxObject(0, 0, 1, 1);
		add(camFollow);

		magenta = new FlxSprite(-80).loadGraphic('assets/images/menuDesat.png');
		magenta.scrollFactor.x = 0;
		magenta.scrollFactor.y = 0.18;
		magenta.setGraphicSize(Std.int(magenta.width * 1.1));
		magenta.updateHitbox();
		magenta.screenCenter();
		magenta.visible = false;
		magenta.antialiasing = true;
		magenta.color = 0xFFfd719b;
		add(magenta);

		menuItems = new FlxTypedGroup<FlxSprite>();
		add(menuItems);

		for (i in 0...optionShit.length)
		{
			var tex = FlxAtlasFrames.fromSparrow('assets/images/main_menu/menu_${optionShit[i].replace(' ', '_')}.png', 'assets/images/main_menu/menu_${optionShit[i].replace(' ', '_')}.xml');
			var menuItem:FlxSprite = new FlxSprite(0, 60 + (i * 160));
			menuItem.frames = tex;
			menuItem.animation.addByPrefix('${optionShit[i]} idle', "idle", 24);
			menuItem.animation.addByPrefix('${optionShit[i]} selected', "selected", 24);
			menuItem.animation.play('idle');
			menuItem.ID = i;
			menuItem.screenCenter(X);
			menuItems.add(menuItem);
			menuItem.scrollFactor.set();
			menuItem.antialiasing = true;
		}

		FlxG.camera.follow(camFollow, null, 0.06);

		var versionShit:FlxText = new FlxText(5, FlxG.height - 36, 0, 'Brainaility Engine v${MainMenuState.version}\nFriday Night Funkin\' v' + Application.current.meta.get('version'), 12);
		versionShit.scrollFactor.set();
		versionShit.setFormat("VCR OSD Mono", 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		add(versionShit);

		changeItem();

		super.create();
	}

	var selectedSomethin:Bool = false;

	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.8)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if (FlxG.keys.justPressed.SEVEN)
		{
			inEditor = true;
			openSubState(new EditorMenuSubState(50, 50));
		}

		if (inEditor)
		{
			if (!EditorMenuSubState.value)
			{
				inEditor = false;
				EditorMenuSubState.value = true;
			}
		}

		if (!selectedSomethin && !inEditor)
		{
			if (controls.UI_UP_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(-1);
			}

			if (controls.UI_DOWN_P)
			{
				FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);
				changeItem(1);
			}

			if (controls.BACK)
			{
				FlxG.switchState(new TitleState());
			}

			if (FlxG.keys.justPressed.EIGHT)
			{
				//FlxG.switchState(new OptionsMenu());
			}

			if (controls.ACCEPT)
			{
				selectedSomethin = true;
				FlxG.sound.play('assets/sounds/confirmMenu' + TitleState.soundExt);

				FlxFlicker.flicker(magenta, 1.1, 0.15, false);

				menuItems.forEach(function(spr:FlxSprite)
				{
					if (curSelected != spr.ID)
					{
						FlxTween.tween(spr, {alpha: 0}, 0.4, {
							ease: FlxEase.quadOut,
							onComplete: function(twn:FlxTween)
							{
								spr.kill();
							}
						});
					}
					else
					{
						FlxFlicker.flicker(spr, 1, 0.06, false, false, function(flick:FlxFlicker)
						{
							var daChoice:String = optionShit[curSelected];

							switch (daChoice)
							{
								case 'story mode':
									FlxG.switchState(new StoryMenuState());
									trace("Story Menu Selected");

								case 'freeplay':
									FlxG.switchState(new FreeplayState());
									trace("Freeplay Menu Selected");
                                case 'donate':
									#if linux
									Sys.command('/usr/bin/xdg-open', ["https://ninja-muffin24.itch.io/funkin", "&"]);
									#else
									FlxG.openURL('https://ninja-muffin24.itch.io/funkin');
									new FlxTimer().start(0.3, function(t:FlxTimer)
									{
										//FlxG.switchState(new MainMenuState());
									});
									#end
									
								case 'options':
									FlxG.switchState(new PlaceholderOptionsState());
									trace("Options Selected");
					
							}
						});
					}
				});
			}
		}

		super.update(elapsed);

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.screenCenter(X);
		});
	}

	function changeItem(huh:Int = 0)
	{
		curSelected += huh;

		if (curSelected >= menuItems.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = menuItems.length - 1;

		menuItems.forEach(function(spr:FlxSprite)
		{
			spr.animation.play('idle');

			if (spr.ID == curSelected)
			{
				spr.animation.play('selected');
				camFollow.setPosition(spr.getGraphicMidpoint().x, spr.getGraphicMidpoint().y);
			}

			spr.updateHitbox();
		});
	}
}

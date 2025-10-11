package states;

import Controls;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.addons.transition.FlxTransitionableState;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.input.keyboard.FlxKey;
import flixel.sound.FlxSound;
import flixel.util.FlxColor;

class SelectionState extends MusicBeatState
{
	var grpMenuShit:FlxTypedGroup<Alphabet>;

	var menuItems:Array<Array<Dynamic>> = [
        ['Something', function():Void {
            trace('something happened');
        }]
    ];

	var curSelected:Int = 0;

	var bg:FlxSprite = null;

	var backAction = function() {
		FlxG.switchState(new MainMenuState());
	};

    public function createMenu()
    {
		bg = new FlxSprite().loadGraphic("assets/images/menuDesat.png");
		bg.scrollFactor.set();
		add(bg);

		grpMenuShit = new FlxTypedGroup<Alphabet>();
		add(grpMenuShit);

		for (i in 0...menuItems.length)
		{
			var songText:Alphabet = new Alphabet(0, (70 * i) + 30, menuItems[i][0], true, false);
			songText.isMenuItem = true;
			songText.targetY = i;
			grpMenuShit.add(songText);
		}

		changeSelection();
    }

	public function new()
	{
		super();
	}

	override function update(elapsed:Float)
	{
		super.update(elapsed);

		var upP = controls.UI_UP_P;
		var downP = controls.UI_DOWN_P;
		var accepted = controls.ACCEPT;
		var back = controls.BACK;

		if (upP)
		{
			changeSelection(-1);
		}
		if (downP)
		{
			changeSelection(1);
		}

		if (accepted)
        {
            var func:Dynamic = menuItems[curSelected][1];
            var action:Void->Void = func;
            action();
        }

		if (back) backAction();


		if (FlxG.keys.justPressed.J)
		{
			// for reference later!
			// PlayerSettings.player1.controls.replaceBinding(Control.LEFT, Keys, FlxKey.J, null);
		}
	}

	function changeSelection(change:Int = 0):Void
	{
		curSelected += change;

		if (curSelected < 0)
			curSelected = menuItems.length - 1;
		if (curSelected >= menuItems.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpMenuShit.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			// item.setGraphicSize(Std.int(item.width * 0.8));

			if (item.targetY == 0)
			{
				item.alpha = 1;
				// item.setGraphicSize(Std.int(item.width));
			}
		}
	}
}

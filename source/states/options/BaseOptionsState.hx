package states.options;

import states.options.objects.Option;
import states.options.OptionsUtil;
import states.options.objects.Option.OptionType;

import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

import backend.ClientPrefs;

import Alphabet;
class BaseOptionsState extends MusicBeatState
{
    var options:Array<Option> = new Array();
    var optionsText:Array<Alphabet> = new Array();

    var selection:Int = 0;
    var canMove = true;
    final optionSpacing = 100;

    override public function create()
    {
        super.create();

        if (options != null) 
            for (option in options) 
            {
                optionsText.push(new Alphabet(option.x + option.width + 10, option.y, ClientPrefs.getName(options.data.save)));
                add(option);
            }

        for (i in 0...optionsText.length - 1)
        {
            add(optionsText[i]);
        }
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (controls.UI_UP_P)
            changeSelection(-1);

        if (controls.UI_DOWN_P)
            changeSelection(1);
    }

    function changeSelection(amount:Int = 0)
    {
        if (!canMove) return;

        selection += amount;
        canMove = false;


        //cool wrapping code :)

        if (selection > options.length)
        {
            selection = 0;
            amount = 0 - options.length;
        }

        if (selection < 0)
        {
            selection = options.length - 1;
            amount = options.length;
        }

        if (Math.abs(selection) > 0) FlxG.sound.play('assets/sounds/scrollMenu' + TitleState.soundExt);

        var i = 0;
        
        for (option in options)
        {
            var nextY = option.y + (optionSpacing * amount);
            FlxTween.tween(option, {y: nextY}, 0.0125, {
                ease: FlxEase.quadInOut,
                onComplete: setCanMove
            });

            FlxTween.tween(optionsText[i], {y: options.y}, 0.0125, { 
                ease: FlxEase.quadInOut
            });

            i ++;
        }
    }

    function setCanMove(tween:FlxTween) canMove = true;
}
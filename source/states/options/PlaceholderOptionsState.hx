package states.options;

import states.SelectionState;
import backend.ClientPrefs;

import flixel.text.FlxText;

//just a placeholder for certain settings, only works for booleans and needs to be manually added, but works for now.
//NOTE TO SELF, after actual menu gets finished, put this in source/archived/. -Brainy

class PlaceholderOptionsState extends SelectionState
{
    var value:FlxText;

    var keys:Array<String> = new Array();

    override public function new()
    {
        super();

        keys = ['ghostTap', 'hideOppo'];

        menuItems = [
            ['Ghost Tapping', function():Void {
                ClientPrefs.setSaveVariable('ghostTap', !ClientPrefs.getSaveVariable('ghostTap'));
            }],
            ['Hide Opponent Notes', function():Void {
                ClientPrefs.setSaveVariable('hideOppo', !ClientPrefs.getSaveVariable('hideOppo'));
            }],
        ];

        value = new FlxText(0, 100, "");
        value.setFormat("assets/fonts/vcr.ttf", 30);

        createMenu();

        add(value);
        bg.color = 0xff5ce9;
    }

    override public function update(elapsed:Float)
    {
        super.update(elapsed);

        if (value != null) value.text = "Value: " + Std.string(ClientPrefs.getSaveVariable(keys[curSelected]));
    }
}
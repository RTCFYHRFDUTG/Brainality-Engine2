package;

import SelectionSubstate;
import flixel.FlxG;
class PauseSubState extends SelectionSubstate
{
    override public function new(x:Float, y:Float)
    {
        super(x, y);

        menuItems = [
            ['Resume', function():Void {
                close();
            }],
            ['Restart Song', function():Void {
                FlxG.resetState();
            }],
            ['Exit to menu', function():Void {
                FlxG.switchState(new MainMenuState());
            }],
            ['Exit game', function():Void {
                Sys.exit(0);
            }]
        ];

        createMenu(x, y);
    }
}

package states.options;

import states.SelectionState;
import states.options.*;

import MainMenuState;

class OptionsMenu extends SelectionState
{
    override public function new()
    {
        super();

        menuItems = [
            ['Gameplay', function():Void {
                FlxG.switchState(()->new GameplayOptionsState());
            }],
            ['Graphics', function():Void {
                trace('this ones a test lol');
            }]
        ];

        createMenu();
        bg.color = 0xff5ce9;
    }
}
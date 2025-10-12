package states;

import flixel.FlxG;
import states.SelectionState;
import backend.Mods;
import flixel.util.FlxTimer;
class ModsMenuState extends SelectionState
{
    override public function new()
    {
        super();

        menuItems = new Array();
        var mods:Array<String> = Mods.getMods();

        for (modName in mods)
        {
            var capturedName = modName;
            menuItems.push([capturedName,
                function():Void {
                    try {
                        trace("Selected Mod: " + capturedName);
                        var results = Polymod.init({
                            modRoot: Mods.modsFolder,
                            dirs: [capturedName]
                        });
                    } catch(e:Dynamic) {
                        trace("Error handling mod: " + capturedName + " -> " + e);
                        TitleState.initialized = false;
                        
                        FlxG.switchState(new TitleState());
                    }
                }
            ]);
        }

        if (menuItems.length == 0)
        {
            menuItems.push([
                "NO MODS INSTALLED",
                function():Void {
                    trace("No mods installed!");
                }
            ]);
        }

        createMenu();
    }
}

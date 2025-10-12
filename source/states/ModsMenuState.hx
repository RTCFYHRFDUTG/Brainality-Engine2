package states;

import flixel.FlxG;
import states.SelectionState;
import backend.Mods;
import CoolUtil;

#if MODS_ALLOWED
import polymod.Polymod;
#end

class ModsMenuState extends SelectionState
{
    override public function new()
    {
        super();

        menuItems = new Array();
        var coolMeta:Array<ModMetadata> = Mods.scan();

        for (mod in getMods())
        {
            menuItems.push([title,
                function():Void {
                    try {
                        trace("Selected Mod: " + );
                        if (capturedMeta.title != "INVALID MOD")
                        {
                            sys.io.File.saveContent("assets/modsList.txt", capturedMeta.title);
                            FlxG.resetGame();
                        }
                    } catch(e:Dynamic) {
                        trace("Error handling mod: " + capturedMeta.title + " -> " + e);
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

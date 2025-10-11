package scripting;

import sys.FileSystem;
import StringTools;

class ScriptUtil
{
    public static function getScripts(ext:String = "hxs", path:String = "./assets/scripts/", getFromMods:Bool = true):Array<String> {
        #if sys
        var scripts:Array<String> = [];

        // Base scripts
        if (FileSystem.exists(path)) {
            for (fileName in FileSystem.readDirectory(path)) {
                if (StringTools.endsWith(fileName, "." + ext)) {
                    scripts.push(fileName.substr(0, fileName.length - (ext.length + 1)));
                }
            }
        }

        // Scripts from mods
        #if MODS_ALLOWED
        if (getFromMods) {
            var mods = Mods.getMods();
            for (mod in mods) {
                var modPath = Mods.modsFolder + mod + "/scripts/";
                if (FileSystem.exists(modPath)) {
                    for (fileName in FileSystem.readDirectory(modPath)) {
                        if (StringTools.endsWith(fileName, "." + ext)) {
                            scripts.push(fileName.substr(0, fileName.length - (ext.length + 1)));
                        }
                    }
                }
            }
        }
        #end

        return scripts;

        #elseif html5
        var scripts:Array<String> = [];
        try {
            var manifestStr = Assets.getText("assets/manifest.json");
            var manifest:Dynamic = Json.parse(manifestStr);

            if (manifest.scripts != null) {
                var scriptList:Array<Dynamic> = manifest.scripts;
                for (s in scriptList) {
                    scripts.push(s);
                }
            }
        } catch(e:Dynamic) {
            trace("Failed to load manifest.json: " + e);
        }
        return scripts;

        #else
        return [];
        #end
    }
}

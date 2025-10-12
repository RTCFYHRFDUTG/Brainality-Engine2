package backend;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

import haxe.Json;

class Mods
{
    public static var modsFolder = "./mods/";
    public static var apiVersion = "1.0.0";

    public static function scan():Array<ModMetadata>
    {
        var mods = getMods();
        var finalMods:Array<ModMetadata> = [];

        for (mod in mods)
        {
            var path = modsFolder + mod + "/pack.json";
            if (FileSystem.exists(path))
            {
                var content = File.getContent(path);
                var meta = ModMetadata.fromJsonStr(content);
                if (meta != null)
                {
                    meta.modPath = modsFolder + mod;
                    finalMods.push(meta);
                }
                else
                {
                    var invalidMeta = new ModMetadata();
                    invalidMeta.title = "INVALID MOD";
                    finalMods.push(invalidMeta);
                }
            }
            else
            {
                var invalidMeta = new ModMetadata();
                invalidMeta.title = "INVALID MOD";
                finalMods.push(invalidMeta);
            }
        }

        return finalMods;
    }


    public static function getMods():Array<String>
    {
        var folders:Array<String> = new Array();

        #if sys
        if (!FileSystem.exists(modsFolder)) return folders;

        for (fileName in FileSystem.readDirectory(modsFolder)) {
            if (FileSystem.isDirectory(modsFolder + fileName)) {
                folders.push(fileName);
            }
        }
        #end

        return folders;
    }
}
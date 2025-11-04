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

    public static function scan():Array<Dynamic>
    {
        var mods = getMods();
        var finalMods:Array<Dynamic> = [];

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
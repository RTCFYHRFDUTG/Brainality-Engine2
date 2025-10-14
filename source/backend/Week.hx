package backend;

import haxe.Json;

#if sys
import sys.FileSystem;
import sys.io.File;
#end

typedef DumbSong = {
    name:String,
    icon:String,
    rgb:Array<Int>
}

typedef Week = {
    name:String,
    songs:Array<DumbSong>,
    ?description:String,
    ?background:String,
    ?menucharacters:Array<String>,
    ?difficulties:Array<String>,
    ?hideFreeplay:Bool,
    ?hideStorymode:Bool
}

class WeekUtil
{
    public static function getWeek(path:String):Week {
        var data:Dynamic = Paths.getJson(path);

        if (!Reflect.hasField(data, "name"))
            throw "Week JSON is missing 'name'";
        if (!Reflect.hasField(data, "songs") || !(data.songs is Array))
            throw "Week JSON is missing 'songs' array";

        var coolSongs:Array<DumbSong> = data.songs;

        for (song in coolSongs) {
            if (!Reflect.hasField(song, "name"))
                throw "A song is missing 'name'";
            if (!Reflect.hasField(song, "icon"))
                throw "A song is missing 'icon'";
            if (!Reflect.hasField(song, "rgb") || !(song.rgb is Array) || song.rgb.length != 3)
                throw "A song has invalid 'rgb' field, must be an array of 3 ints";
        }

        return cast data;
    }

    public static function getWeeks(?checkMods:Bool):Array<Week>
    {
        if (checkMods)
        {
            trace("Mods folder checking not supported at this time!");
        }

        var weeks:Array<Week> = new Array();

        var tempWeeks:Array<String> = new Array();

        for (week in FileSystem.readDirectory("assets/weeks/"))
        {
            if (!FileSystem.isDirectory("assets/weeks/" + week) && StringTools.endsWith(week.toLowerCase(), ".json")) {
                tempWeeks.push("assets/weeks/" + week);
            }
        }

        for (week in tempWeeks)
        {
            var curWeek = getWeek(week);

            if (curWeek != null) weeks.push(curWeek);
        }

        return weeks;
    }
}
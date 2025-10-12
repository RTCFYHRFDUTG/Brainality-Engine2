package backend;

import StringTools;
import sys.FileSystem;

class Paths
{
    public static function getSong(songName:String, type:String = 'Inst', ext:String="ogg"):String 
    {
        var v:String = 'assets/songs/${formatSong(songName)}/${type}.${ext}';
        if (!FileSystem.exists(v))
        {
            trace('Song does not exists!');
            v = 'assets/sounds/cancelMenu.' + ext;
        }

        trace('Getting song from ${v}');

        return v;
    }

    public static function getSpritesheet(image:String):Array<String>
    {
        var path = 'assets/images/${image}';
        trace('loading from ${path}');
        return [path + ".png", path + ".xml"];
    }

    public inline static function getImage(image):String
        return getSpritesheet(image)[0];

    public inline static function formatSong(song:String):String return StringTools.replace(song.toLowerCase(), ' ', '-');
}
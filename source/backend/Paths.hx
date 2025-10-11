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

    public inline static function formatSong(song:String):String return StringTools.replace(song.toLowerCase(), ' ', '-');
}
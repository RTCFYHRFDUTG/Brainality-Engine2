package states.options;

import states.options.objects.Option;
class BaseOptionsState extends MusicBeatState
{
    var options:Array<Option> = new Array();
    override public function new()
    {
        super();
        
        for (option in options) add(option);
    }
}
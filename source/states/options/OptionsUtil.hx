package states.options;

import states.options.objects.Option;

class OptionsUtil
{
    public static function createOption(save:String, type:OptionType, min = null, max = null):Option
    {
        return new Option({save; type; min; max;});
    }
}
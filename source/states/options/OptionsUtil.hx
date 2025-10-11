package states.options;

import states.options.objects.Option;

class OptionsUtil
{
    public static function createOption(data:OptionData):Option
    {
        return new Option(data);
    }
}
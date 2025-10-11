package states.options;

import states.options.objects.Option.OptionType;
class GameplayOptionsState extends BaseOptionsState
{
    override public function new()
    {
        var option = OptionsUtil.createOption(
            "downscroll",
            OptionType.BOOL
        );
        options.push(option);

        super();
    }
}
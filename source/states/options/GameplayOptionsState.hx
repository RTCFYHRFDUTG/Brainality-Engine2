package states.options;

import states.options.OptionsUtil;
class GameplayOptionsState extends BaseOptionsState
{
    override public function new()
    {
        var option = createOption({
            "downscroll",
            BOOL
        });
        options.push(options);

        super();
    }
}
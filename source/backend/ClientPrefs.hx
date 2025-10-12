package backend;

import flixel.input.gamepad.FlxGamepadInputID;
import flixel.input.keyboard.FlxKey;

//thanks psych i'm too lazy to code keybinds myself
//code from Controls.hx also stolen from psych engine
class ClientPrefs
{
    public static var data:Map<String, Dynamic> = new Map();

    public static var display:Map<String, Array<String>> = new Map();

    public static var keyBinds:Map<String, Array<FlxKey>> = [
		//Key Bind, Name for ControlsSubState
		'note_up'		=> [J, UP],
		'note_left'		=> [D, LEFT],
		'note_down'		=> [F, DOWN],
		'note_right'	=> [K, RIGHT],
		
		'ui_up'			=> [W, UP],
		'ui_left'		=> [A, LEFT],
		'ui_down'		=> [S, DOWN],
		'ui_right'		=> [D, RIGHT],
		
		'accept'		=> [SPACE, ENTER],
		'back'			=> [BACKSPACE, ESCAPE],
		'pause'			=> [ENTER, ESCAPE],
		'reset'			=> [R],
		
		'volume_mute'	=> [ZERO],
		'volume_up'		=> [NUMPADPLUS, PLUS],
		'volume_down'	=> [NUMPADMINUS, MINUS],
		
		'debug_1'		=> [SEVEN],
		'debug_2'		=> [EIGHT]
	];
	public static var gamepadBinds:Map<String, Array<FlxGamepadInputID>> = [
		'note_up'		=> [DPAD_UP, Y],
		'note_left'		=> [DPAD_LEFT, X],
		'note_down'		=> [DPAD_DOWN, A],
		'note_right'	=> [DPAD_RIGHT, B],
		
		'ui_up'			=> [DPAD_UP, LEFT_STICK_DIGITAL_UP],
		'ui_left'		=> [DPAD_LEFT, LEFT_STICK_DIGITAL_LEFT],
		'ui_down'		=> [DPAD_DOWN, LEFT_STICK_DIGITAL_DOWN],
		'ui_right'		=> [DPAD_RIGHT, LEFT_STICK_DIGITAL_RIGHT],
		
		'accept'		=> [A, START],
		'back'			=> [B],
		'pause'			=> [START],
		'reset'			=> [BACK]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;
	public static var defaultButtons:Map<String, Array<FlxGamepadInputID>> = null;

	public static function resetKeys(controller:Null<Bool> = null) //Null = both, False = Keyboard, True = Controller
	{
		if(controller != true)
			for (key in keyBinds.keys())
				if(defaultKeys.exists(key))
					keyBinds.set(key, defaultKeys.get(key).copy());

		if(controller != false)
			for (button in gamepadBinds.keys())
				if(defaultButtons.exists(button))
					gamepadBinds.set(button, defaultButtons.get(button).copy());
	}

	public static function clearInvalidKeys(key:String)
	{
		var keyBind:Array<FlxKey> = keyBinds.get(key);
		var gamepadBind:Array<FlxGamepadInputID> = gamepadBinds.get(key);
		while(keyBind != null && keyBind.contains(NONE)) keyBind.remove(NONE);
		while(gamepadBind != null && gamepadBind.contains(NONE)) gamepadBind.remove(NONE);
	}

	public static function loadDefaultKeys()
	{
		defaultKeys = keyBinds.copy();
		defaultButtons = gamepadBinds.copy();
	}

    
    public static function getPrefs()
    {
        addSaveVariable("ghostTap", true, "Ghost Tapping", "You don't get a miss from pressing keys while there aren't notes!");
		addSaveVariable("hideOppo", false, "Hide Opponent Notes", "If checked, Opponent Notes Get Hidden");
        addSaveVariable("downscroll", false, "Downscroll", "Notes go down instead of up. Simple enough.");
        addSaveVariable("middleScroll", false, "Middlescroll", "Player notes get centered");
        addSaveVariable("opponentNoteOpacity", 1, "Opponent Note Opacity", "Controls how visibles the opponents notes are.");
        addSaveVariable("fps", true, "Show FPS", "If checked, FPS will be shown.");
    }

	inline public static function getName(key:String):String
	{
		return display.get(key)[0];
	}

	inline public static function getDesc(key:String):String
	{
		return display.get(key)[1];
	}

    inline public static function getSaveVariable(key:String)
    {
        return data.get(key);
    }

    inline public static function setSaveVariable(key:String, v:Dynamic)
    {
        data.set(key, v);
    }

    public static function addSaveVariable(key:String, v:Dynamic, title:String, desc:String)
    {
        setSaveVariable(key, v);

        display.set(key, [title, desc]);
    }
}
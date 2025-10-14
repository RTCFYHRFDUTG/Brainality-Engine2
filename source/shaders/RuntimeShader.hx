package shaders;

import flixel.system.FlxShader;

class RuntimeShader extends FlxShader
{
    function new(code:String)
    {
        super();
        fragmentShader = code;
    }
}
package player;
import flixel.FlxBasic;
import flixel.FlxG;
import flixel.input.keyboard.FlxKey;

/**
 * Basically a struct that player-type classes can use to pass inputs around.
 * @author Samuel Bumgardner
 */
class Input
{
	public var leftJustPressed:Bool = false;
	public var rightJustPressed:Bool = false;
	public var downJustPressed:Bool = false;
	public var jumpJustPressed:Bool = false;
	
	public var leftPressed:Bool = false;
	public var rightPressed:Bool = false;
	public var downPressed:Bool = false;
	public var jumpPressed:Bool = false;
	
	public var leftJustReleased:Bool = false;
	public var rightJustReleased:Bool = false;
	public var downJustReleased:Bool = false;
	public var jumpJustReleased:Bool = false;
	
	public function new() {}
}
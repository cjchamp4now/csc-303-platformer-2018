package player.fsm;

/**
 * @author Samuel Bumgardner
 */
@:enum
class PlayerStates 
{
	public static var NO_CHANGE(default, never):Int = -1;
	public static var STAND(default, never):Int = 0;
	public static var RUN(default, never):Int = 1;
	public static var JUMP(default, never):Int = 2;
	public static var DOUBLE(default, never):Int = 3;
	public static var FALL(default, never):Int = 4;
	public static var CROUCH(default, never):Int = 5;
	// Commented out some states for this example so everything has animations.
	// public static var SLIDEDASH(default, never):Int = 7;
	// public static var CLIMB(default, never):Int = 4;
}
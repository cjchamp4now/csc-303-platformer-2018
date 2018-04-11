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
	public static var CROUCH(default, never):Int = 3;
	public static var ATTACK(default, never):Int = 6;
}
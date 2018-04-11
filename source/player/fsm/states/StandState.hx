package player.fsm.states;

import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * State for when the player is not moving or taking any other action.
 * @author Samuel Bumgardner
 */
class StandState extends PlayerState
{

	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{
		if (input.jumpJustPressed) {
			return PlayerStates.JUMP;
		}
		
		if (input.downPressed) {
			return PlayerStates.CROUCH;
		} 
		
		if (input.shiftPressed) {
			return PlayerStates.ATTACK;
		}
		var horizontalInput:Int = 0;
		if (input.leftPressed) {
			horizontalInput--;
		}
		if (input.rightPressed) {
			horizontalInput++;
		}
		
		if (horizontalInput != 0) {
			return PlayerStates.RUN;
		} 
		
		
		return PlayerStates.NO_CHANGE;
	}
	
	override public function update():Void 
	{
		// Do nothing when standing still.
	}
	
	override public function transitionIn():Void 
	{
		this.managedHero.color = FlxColor.ORANGE;
		this.managedHero.drag.x = Player.STANDING_DECELERATION;
	}
	
	override public function transitionOut():Void 
	{
		this.managedHero.color = FlxColor.WHITE;
		this.managedHero.drag.x = 0;
	}
	
}
package player.fsm.states;

import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * State for when the player is not moving or taking any other action.
 * @author Samuel Bumgardner
 */
class StandState extends GroundState
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
		
		return super.handleInput(input);
	}
	
	override public function update():Void 
	{
		if (this.managedHero.animation.finished 
				&& this.managedHero.animation.curAnim.name != Player.STAND_ANIMATION) {
			
			this.managedHero.animation.play(Player.STAND_ANIMATION);
		}

	}
	
	override public function transitionIn():Void 
	{
		this.managedHero.remainingAirJumps = Player.MAX_AIR_JUMPS;
		
		this.managedHero.color = FlxColor.ORANGE;
		this.managedHero.drag.x = Player.STANDING_DECELERATION;
		
		if (this.managedHero.animation.finished) {
			this.managedHero.animation.play(Player.STAND_ANIMATION);
		}
	}
	
	override public function transitionOut():Void 
	{
		this.managedHero.color = FlxColor.WHITE;
		this.managedHero.drag.x = 0;
	}
	
}
package player.fsm.states;

import flixel.FlxObject;
import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * State for when the player is moving horizontally along the ground.
 * @author Samuel Bumgardner
 */
class RunState extends PlayerState
{

	private var direction:Int = 0;
	
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
		
		if (horizontalInput == 0) {
			return PlayerStates.STAND;
		} 
		else {
			direction = horizontalInput;
		}
		
		return PlayerStates.NO_CHANGE;
	}
	
	override public function update():Void 
	{
		this.managedHero.velocity.x = Player.MAX_RUN_SPEED * direction;
	}
	
	override public function transitionIn():Void 
	{
		this.managedHero.color = FlxColor.BLUE;
	}
	
	override public function transitionOut():Void 
	{
		this.managedHero.color = FlxColor.WHITE;
	}
	
}
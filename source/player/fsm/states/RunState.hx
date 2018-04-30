package player.fsm.states;

import flixel.FlxObject;
import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * State for when the player is moving horizontally along the ground.
 * @author Samuel Bumgardner
 */
class RunState extends GroundState
{	
	private var movementDirection:Int = 0;
	
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
		
		this.movementDirection = 0;
		if (input.leftPressed) {
			this.movementDirection--;
		}
		if (input.rightPressed) {
			this.movementDirection++;
		}
		
		if (movementDirection == 0) {
			managedHero.animation.play(Player.SKID_ANIMATION);
			return PlayerStates.STAND;
		} 
		else {			
			if (movementDirection == 1 && this.managedHero.facing == FlxObject.LEFT
					|| movementDirection == -1 && this.managedHero.facing == FlxObject.RIGHT) {
				this.managedHero.facing = movementDirection == -1 ? FlxObject.LEFT : FlxObject.RIGHT;
				this.managedHero.flipX = this.managedHero.facing == FlxObject.LEFT;
			}
		}
		
		return super.handleInput(input);
	}
	
	override public function update():Void 
	{
		this.managedHero.velocity.x = Player.MAX_RUN_SPEED * movementDirection;
	}
	
	override public function transitionIn():Void 
	{
		this.managedHero.animation.play(Player.RUN_ANIMATION, false);
	}
}
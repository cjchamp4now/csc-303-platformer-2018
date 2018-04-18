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
		
		var direction:Int = 0;
		if (input.leftPressed) {
			direction = direction | FlxObject.LEFT;
		}
		if (input.rightPressed) {
			direction = direction | FlxObject.RIGHT;
		}
		
		if (direction == 0 || direction == FlxObject.LEFT | FlxObject.RIGHT) {
			managedHero.animation.play(Player.SKID_ANIMATION);
			return PlayerStates.STAND;
		} 
		else {			
			if (direction != this.managedHero.facing) {
				this.managedHero.facing = direction;
				this.managedHero.flipX = this.managedHero.facing == FlxObject.LEFT;
			}
		}
		
		return PlayerStates.NO_CHANGE;
	}
	
	override public function update():Void 
	{
		this.managedHero.velocity.x = Player.MAX_RUN_SPEED * (this.managedHero.facing == FlxObject.RIGHT ? 1 : -1);
	}
	
	override public function transitionIn():Void 
	{
		this.managedHero.color = FlxColor.BLUE;
		this.managedHero.animation.play(Player.RUN_ANIMATION, false);
	}
	
	override public function transitionOut():Void 
	{
		this.managedHero.color = FlxColor.WHITE;
	}
	
}
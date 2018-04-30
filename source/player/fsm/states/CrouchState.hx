package player.fsm.states;

import flixel.math.FlxRect;
import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * State for when the player is ducking. Also allows sliding. Fun!
 * @author Samuel Bumgardner
 */
class CrouchState extends GroundState
{
	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{
		
		var horizontalInput:Int = 0;
		
		if (!input.downPressed) {
			return PlayerStates.STAND;
		}
		
		return super.handleInput(input);
	}
	
	override public function update():Void {}
	
	override public function transitionIn():Void 
	{		
		this.managedHero.height = Player.CROUCH_HEIGHT;
		this.managedHero.y += Player.HEIGHT - Player.CROUCH_HEIGHT;
		this.managedHero.offset.y += Player.HEIGHT - Player.CROUCH_HEIGHT;
		
		this.managedHero.drag.x = Player.CROUCHING_DECELERATION;
		
		this.managedHero.animation.play(Player.CROUCH_ANIMATION);
	}
	
	override public function transitionOut():Void 
	{		
		this.managedHero.height = Player.HEIGHT;
		this.managedHero.y -= Player.HEIGHT - Player.CROUCH_HEIGHT;
		this.managedHero.offset.y -= Player.HEIGHT - Player.CROUCH_HEIGHT;
		
		this.managedHero.drag.x = 0;
		
		if (this.managedHero.animation.name == Player.CROUCH_ANIMATION) {
			this.managedHero.animation.stop();
		}
	}
	
}
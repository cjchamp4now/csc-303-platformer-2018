package source.player.fsm.states;

import player.fsm.PlayerStates;
import player.fsm.states.AirState;
import player.Player;
import flixel.FlxG;
import player.Input;

/**
 * ...
 * @author Cory Jackson
 */
class AirDash extends AirState
{
	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{		
		if (FlxG.keys.justReleased.F) {
			this.managedHero.remainingAirJumps--;
			return PlayerStates.FALL;
		}
		this.movementDirection = 1;
		return super.handleInput(input);
	}
	
	override public function transitionIn():Void 
	{
		//trace("test1");
		this.managedHero.velocity.x = Player.MAX_RUN_SPEED;
		this.managedHero.velocity.y = 0;
		this.managedHero.acceleration.x = Player.MAX_RUN_SPEED;
		this.managedHero.acceleration.y = 0;
		this.managedHero.animation.play(Player.RUN_ANIMATION);
		//FlxG.sound.play(AssetPaths.woosh__wav, .5);
	}
	
	override public function transitionOut():Void 
	{		
		if (this.managedHero.animation.name == Player.RUN_ANIMATION) {
			this.managedHero.animation.stop();
		}
		this.managedHero.velocity.x = 0;
		this.managedHero.velocity.y = 0;
		this.managedHero.acceleration.x = 0;
		this.managedHero.acceleration.y = 400;
	}
}
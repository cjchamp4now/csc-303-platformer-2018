package player.fsm.states;

import flixel.FlxG;
import flixel.util.FlxColor;
import player.Input;
import player.fsm.PlayerState;
import player.Player;

/**
 * ...
 * @author Samuel Bumgardner
 */
class FallState extends AirState
{

	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{		
		if (FlxG.keys.justPressed.SPACE && this.managedHero.remainingAirJumps > 0){
			this.managedHero.remainingAirJumps--;
			return PlayerStates.DOUBLE;
		}
		
		return super.handleInput(input);
	}
	
	override public function transitionIn():Void
	{
		if (managedHero.velocity.y < 0) {
			managedHero.velocity.y = 0;
		}
		
		this.managedHero.animation.play(Player.FALLING_AIR_ANIMATION);
	}
	
	override public function transitionOut():Void 
	{		
		if (this.managedHero.animation.name == Player.FALLING_AIR_ANIMATION) {
			this.managedHero.animation.stop();
		}
	}
}
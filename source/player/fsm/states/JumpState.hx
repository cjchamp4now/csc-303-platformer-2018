package player.fsm.states;

import flixel.FlxObject;
import flixel.FlxG;
import flixel.util.FlxColor;
import player.fsm.PlayerState;
import player.Input;

/**
 * State for when the player initates a jump.
 * @author Samuel Bumgardner
 */
class JumpState extends AirState
{

	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{		
		if (FlxG.keys.justReleased.SPACE || managedHero.velocity.y >= 0) {
			return PlayerStates.FALL;
		} else if (input.dashJustPressed && this.managedHero.remainingAirJumps > 0){
			this.managedHero.remainingAirJumps--;
			return PlayerStates.AIRDASH;
		}
		
		return super.handleInput(input);
	}
	
	override public function transitionIn():Void 
	{		
		this.managedHero.velocity.y = Player.JUMP_VELOCITY;
		
		this.managedHero.animation.play(Player.RISING_AIR_ANIMATION);
		FlxG.sound.play(AssetPaths.jump_start__wav, .5);
	}
	
	override public function transitionOut():Void 
	{		
		if (this.managedHero.animation.name == Player.RISING_AIR_ANIMATION) {
			this.managedHero.animation.stop();
		}
	}
}
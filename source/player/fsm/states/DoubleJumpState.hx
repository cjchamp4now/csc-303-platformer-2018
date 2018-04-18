package player.fsm.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * ...
 * @author Ted Green
 */
class DoubleJumpState extends AirState 
{

	
	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{
		if (FlxG.keys.justReleased.SPACE || managedHero.velocity.y >= 0) {
			return PlayerStates.FALL;
		}
		
		return super.handleInput(input);
	}
	
	override public function transitionIn():Void 
	{
		this.managedHero.color = FlxColor.GREEN;
		this.managedHero.velocity.y = Player.DOUBLE_JUMP_VELOCITY;
		
		this.managedHero.animation.play(Player.RISING_AIR_ANIMATION);
		FlxG.sound.play(AssetPaths.jump_double__wav, .5);
	}
	
	override public function transitionOut():Void 
	{
		this.managedHero.color = FlxColor.WHITE;
		
		if (this.managedHero.animation.name == Player.RISING_AIR_ANIMATION) {
			this.managedHero.animation.stop();
		}
	}
	
}
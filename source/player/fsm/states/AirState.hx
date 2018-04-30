package player.fsm.states;

import flixel.FlxG;
import flixel.FlxObject;
import flixel.util.FlxColor;
import player.fsm.PlayerState;
import player.Player;

/**
 * ...
 * @author Samuel Bumgardner
 */
class AirState extends PlayerState
{
	private var movementDirection:Int = 0;
	
	public function new(hero:Player) 
	{
		super(hero);
		
	}
	
	override public function handleInput(input:Input):Int 
	{
		if (this.managedHero.isTouching(FlxObject.DOWN) && managedHero.velocity.y >= 0) {
			FlxG.sound.play(AssetPaths.jump_land__wav, .5);
			return PlayerStates.STAND;
		}
		
		this.movementDirection = 0;
		if (input.leftPressed) {
			this.movementDirection--;
		}
		if (input.rightPressed) {
			this.movementDirection++;
		}
		
		return PlayerStates.NO_CHANGE;
	}
	
	override public function update():Void 
	{
		this.managedHero.velocity.x = Player.MAX_RUN_SPEED * movementDirection;
	}
}
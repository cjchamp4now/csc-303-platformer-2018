package player.fsm.states;

import flixel.FlxObject;
import player.fsm.PlayerState;
import player.Player;

/**
 * ...
 * @author Samuel Bumgardner
 */
class GroundState extends PlayerState
{

	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{
		if (!this.managedHero.isTouching(FlxObject.DOWN)) {
			return PlayerStates.FALL;
		}
		
		return PlayerStates.NO_CHANGE;
	}
}
package player.fsm.states;

import flixel.math.FlxRect;
import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * State for when the player is Attacking. Or when they wish to getb bigger!
 * @author Samuel Bumgardner
 */
class AttackState extends PlayerState
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
		
		if (!input.shiftPressed) {
			return PlayerStates.STAND;
		}
		
		return PlayerStates.NO_CHANGE;
	}
	
	override public function update():Void {}
	
	override public function transitionIn():Void 
	{
		this.managedHero.color = FlxColor.CYAN;
		//this.managedHero.width = Player.ATTACK_LENGTH;
		this.managedHero.setGraphicSize(64, 64);
		this.managedHero.updateHitbox();

		
		this.managedHero.x -= Player.ATTACK_LENGTH / 4;
				
	}
	
	override public function transitionOut():Void 
	{
		this.managedHero.color = FlxColor.WHITE;
		this.managedHero.setGraphicSize(32, 64);
		this.managedHero.updateHitbox();		
		//this.managedHero.width = Player.LENGTH;
		this.managedHero.x += Player.ATTACK_LENGTH / 4;
				
	}
	
}
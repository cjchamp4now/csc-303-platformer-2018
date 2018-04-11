package player.fsm.states;

import flixel.math.FlxRect;
import flixel.util.FlxColor;
import player.fsm.PlayerState;

/**
 * State for when the player is ducking. Also allows sliding. Fun!
 * @author Samuel Bumgardner
 */
class CrouchState extends PlayerState
{
	private static var topHalfOfGraphicRect(default, never) = new FlxRect(0, 0, 32, 32);
	
	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{
		if (input.jumpJustPressed) {
			return PlayerStates.JUMP;
		}
		
		if (!input.downPressed) {
			return PlayerStates.STAND;
		}
		
		return PlayerStates.NO_CHANGE;
	}
	
	override public function update():Void {}
	
	override public function transitionIn():Void 
	{
		this.managedHero.color = FlxColor.RED;
		
		this.managedHero.height = Player.CROUCH_HEIGHT;
		this.managedHero.clipRect = topHalfOfGraphicRect;
		this.managedHero.y += Player.HEIGHT - Player.CROUCH_HEIGHT;
		
		this.managedHero.drag.x = Player.CROUCHING_DECELERATION;
	}
	
	override public function transitionOut():Void 
	{
		this.managedHero.color = FlxColor.WHITE;
		
		this.managedHero.height = Player.HEIGHT;
		this.managedHero.clipRect = null;
		this.managedHero.y -= Player.HEIGHT - Player.CROUCH_HEIGHT;
		
		this.managedHero.drag.x = 0;
	}
	
}
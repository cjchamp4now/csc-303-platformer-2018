package player.fsm.states;

import flixel.FlxObject;
import flixel.math.FlxRect;
import flixel.util.FlxColor;
import player.fsm.PlayerState;
import Sys;

/**
 * State for when the player is ducking. Also allows sliding. Fun!
 * @author Samuel Bumgardner
 */
class SlideDashState extends PlayerState
{
	private var slideTime:Float;
	
	private var jumpWasReleased:Bool;
	
	private static var topHalfOfGraphicRect(default, never) = new FlxRect(0, 0, 32, 32);
	
	public function new(hero:Player) 
	{
		super(hero);
	}
	
	override public function handleInput(input:Input):Int 
	{
		if (input.jumpJustPressed && jumpWasReleased && !input.downPressed) {
			return PlayerStates.JUMP;
		}
		
		if (input.jumpJustReleased) {
			jumpWasReleased = true;
		}
		
		if (slideTime<=Sys.time()) {
			return PlayerStates.STAND;
		}
		
		return PlayerStates.NO_CHANGE;
	}
	
	override public function update():Void {}
	
	override public function transitionIn():Void 
	{
		this.managedHero.color = FlxColor.YELLOW;
		
		this.managedHero.height = Player.CROUCH_HEIGHT;
		this.managedHero.clipRect = topHalfOfGraphicRect;
		this.managedHero.y += Player.HEIGHT - Player.CROUCH_HEIGHT;
		
		this.managedHero.drag.x = Player.CROUCHING_DECELERATION;
		
		this.managedHero.velocity.x = Player.MAX_RUN_SPEED * (this.managedHero.facing == FlxObject.RIGHT ? 1 : -1);
		
		slideTime = Sys.time() + .5;
		
		jumpWasReleased=false;
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
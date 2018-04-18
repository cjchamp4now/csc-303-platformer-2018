package player;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.system.FlxAssets.FlxGraphicAsset;
import haxe.ds.Vector;
import player.fsm.PlayerStates;
import player.fsm.State;
import player.fsm.states.CrouchState;
import player.fsm.states.JumpState;
import player.fsm.states.RunState;
import player.fsm.states.StandState;
import player.fsm.states.SlideDashState;
import player.fsm.states.ClimbState;
import player.fsm.states.DoubleJumpState;

/**
 * Base hero class that player-controlled objects should descend from.
 * @author Samuel Bumgardner
 */
class Player extends FlxSprite
{
	public static var LENGTH(default, never):Int = 8;
	public static var HEIGHT(default, never):Int = 28;
	public static var CROUCH_HEIGHT(default, never):Float = 16;
	
	public static var OFFSET_X(default, never):Int = 20;
	public static var OFFSET_Y(default, never):Int = 20;
	
	public static var MAX_RUN_SPEED(default, never):Float = 200;
	public static var MAX_Y_SPEED(default, never):Float = 350;
	public static var JUMP_VELOCITY(default, never):Float = -350;
	public static var GRAVITY(default, never):Float = 400;
	public static var STANDING_DECELERATION(default, never):Float = 500;
	public static var CROUCHING_DECELERATION(default, never):Float = 200;
	  
	public static var STAND_ANIMATION(default, never):String = "stand";
	public static var RUN_ANIMATION(default, never):String = "run";
	public static var SKID_ANIMATION(default, never):String = "skid";
	public static var CROUCH_ANIMATION(default, never):String = "crouch";
	public static var RISING_AIR_ANIMATION(default, never):String = "risingAir";
	public static var FALLING_AIR_ANIMATION(default, never):String = "fallingAir";
	
	private var state:State;
	private var states:Vector<State> = new Vector<State>(8);

	
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		acceleration.y = GRAVITY;
		maxVelocity.set(MAX_RUN_SPEED, MAX_Y_SPEED);
		
		loadGraphic(AssetPaths.HeroSpritesheet__png, true, 48, 48);
		offset.set(OFFSET_X, OFFSET_Y);
		width = LENGTH;
		height = HEIGHT;
		
		animation.add(STAND_ANIMATION, [0], 1, false);
		animation.add(RUN_ANIMATION, [1, 2, 3, 1, 4, 5], 10);
		animation.add(SKID_ANIMATION, [6, 7, 7, 8], 8, false);
		animation.play(STAND_ANIMATION);
		
		
		states[PlayerStates.STAND] = new StandState(this);
		states[PlayerStates.RUN] = new RunState(this);
		states[PlayerStates.JUMP] = new JumpState(this);
		states[PlayerStates.CROUCH] = new CrouchState(this);
		states[PlayerStates.SLIDEDASH] = new SlideDashState(this);
		states[PlayerStates.CLIMB] = new ClimbState(this);
		states[PlayerStates.DOUBLE] = new DoubleJumpState(this);
		
		state = states[PlayerStates.STAND];
		state.transitionIn();
	}
	
	/**
	 * Helper function to gather player-relevant inputs needed each update.
	 * @return Input object describing the state of all buttons.
	 */
	private inline function captureInput():Input {
		var input:Input = new Input();
		
		input.leftJustPressed = FlxG.keys.justPressed.LEFT;
		input.rightJustPressed = FlxG.keys.justPressed.RIGHT;
		input.downJustPressed = FlxG.keys.justPressed.DOWN;
		input.jumpJustPressed = FlxG.keys.justPressed.SPACE;
		
		input.leftPressed = FlxG.keys.pressed.LEFT;
		input.rightPressed = FlxG.keys.pressed.RIGHT;
		input.downPressed = FlxG.keys.pressed.DOWN;
		input.jumpPressed = FlxG.keys.pressed.SPACE;
		
		input.leftJustReleased = FlxG.keys.justReleased.LEFT;
		input.rightJustReleased = FlxG.keys.justReleased.RIGHT;
		input.downJustReleased = FlxG.keys.justReleased.DOWN;
		input.jumpJustReleased = FlxG.keys.justReleased.SPACE;
		
		return input;
	}
	
	/**
	 * Helper function to separate this messy FSM logic from the rest of the update code.
	 */
	private inline function applyInputAndTransitionStates(input:Input):Void {
		var nextState:Int;
		do {
			nextState = state.handleInput(input);
			if (nextState != PlayerStates.NO_CHANGE) {
				state.transitionOut();
				state = states[nextState];
				state.transitionIn();
			}
		} while (nextState != PlayerStates.NO_CHANGE);
	}
	
	override public function update(elapsed:Float) {
		var input:Input = captureInput();
		applyInputAndTransitionStates(input);
		state.update();
		
		super.update(elapsed);
	}
}
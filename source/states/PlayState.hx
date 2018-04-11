package states;

import environment.Ground;
import flixel.FlxG;
import flixel.FlxState;
import flixel.group.FlxGroup.FlxTypedGroup;
import player.Player;

class PlayState extends FlxState
{
	private static var GROUND_TILE_COUNT(default, never):Int = 18;
	private static var GROUND_START_X(default, never):Float = 32;
	private static var GROUND_START_Y(default, never):Float = 320;
	
	private static var WALL_TILE_COUNT(default, never):Int = 3;
	private static var WALL_START_X(default, never):Float = 240;
	private static var WALL_START_Y(default, never):Float = 192;
	
	private static var HERO_START_X(default, never):Float = 320;
	private static var HERO_START_Y(default, never):Float = 256;
	
	private var player:Player;
	private var groundGroup:FlxTypedGroup<Ground>;
	
	override public function create():Void {
		super.create();
		instantiateEntities();
		addEntities();
	}
	
	/**
	 * Helper function that generates all starting objects.
	 */
	private function instantiateEntities():Void {
		player = new Player(HERO_START_X, HERO_START_Y);
		
		groundGroup = new FlxTypedGroup<Ground>();
		for (i in 0...GROUND_TILE_COUNT) {
			groundGroup.add(new Ground(GROUND_START_X + Ground.LENGTH * i, GROUND_START_Y));
		}
		for (i in 0...WALL_TILE_COUNT) {
			groundGroup.add(new Ground(WALL_START_X, WALL_START_Y + Ground.HEIGHT * i));
		}
	}
	
	/**
	 * Helper function that adds all starting objects to the Scene.
	 */
	private function addEntities():Void {
		add(player);
		add(groundGroup);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		FlxG.collide(player, groundGroup);
	}
}

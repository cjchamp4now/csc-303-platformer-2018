package states;

import flixel.FlxG;
import flixel.FlxState;
import flixel.tile.FlxTilemap;
import player.Player;

/**
 * ...
 * @author Samuel Bumgardner
 */
class ArrayLoadedState extends FlxState
{
	
	private static var HERO_START_X(default, never):Float = 320;
	private static var HERO_START_Y(default, never):Float = 256;
	
	private var player:Player;
	private var map:FlxTilemap;
	
	override public function create():Void {
		super.create();
		instantiateEntities();
		instantiateMap();
		addAll();
	}
	
	/**
	 * Helper function that generates all starting objects.
	 */
	private function instantiateEntities():Void {
		player = new Player(HERO_START_X, HERO_START_Y);
	}
	
	/**
	 * 
	 */
	private function instantiateMap():Void {
		map = new FlxTilemap();
		map.loadMapFromArray([
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,1,1,1,1,0,0,0,0,0,1,
			1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,
			1,0,0,0,0,0,1,0,0,0,0,0,0,0,0,0,1,1,1,1,
			1,0,0,0,0,0,1,1,0,0,0,0,0,0,0,0,1,1,1,1,
			1,0,0,0,0,0,1,1,1,0,0,0,0,0,0,0,1,1,1,1,
			1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1,1],
			20, 15, AssetPaths.Brick__png, 32, 32);
	}
	
	/**
	 * Helper function that adds all starting objects to the Scene.
	 */
	private function addAll():Void {
		add(player);
		add(map);
	}

	override public function update(elapsed:Float):Void {
		super.update(elapsed);
		FlxG.collide(player, map);
	}
	
}
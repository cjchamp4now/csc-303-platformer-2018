package states;

import flixel.FlxCamera.FlxCameraFollowStyle;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmoLoader;
import flixel.tile.FlxTilemap;
import player.Player;

/**
 * ...
 * @author Samuel Bumgardner
 */
class OgmoLoadedState extends FlxState
{
	private var player:Player;
	private var levelLoader:FlxOgmoLoader;
	private var map:FlxTilemap;
	
	override public function create():Void {
		instantiateEntities();
		setUpLevel();
		addAll();
		
		FlxG.camera.follow(player, FlxCameraFollowStyle.PLATFORMER, 1);
		FlxG.camera.zoom = 2;
		
		FlxG.sound.playMusic(AssetPaths.rightHandMate_v8__wav);
		
		super.create();
	}
	
	/**
	 * Helper function that generates all starting objects.
	 */
	private function instantiateEntities():Void {
		player = new Player();
	}
	
	/**
	 * 
	 */
	private function setUpLevel():Void {
		levelLoader = new FlxOgmoLoader(AssetPaths.brick_land__oel);
		
		map = levelLoader.loadTilemap(AssetPaths.Brick__png, 32, 32, "solid_obstacles");
		map.setTileProperties(1, FlxObject.ANY);
		
		levelLoader.loadEntities(placeEntities, "entities");
	}
	
	private function placeEntities(entityName:String, entityData:Xml):Void {
		var x:Int = Std.parseInt(entityData.get("x"));
		var y:Int = Std.parseInt(entityData.get("y"));
		if (entityName == "player") {
			player.x = x;
			player.y = y;
		}
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
		FlxG.collide(map, player);
		
		if (FlxG.keys.justPressed.N) {
			FlxG.switchState(new PlayState());
		}
	}
}
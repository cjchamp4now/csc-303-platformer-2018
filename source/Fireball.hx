package;

import flixel.FlxSprite;
import flixel.util.FlxColor;

/**
 * Fireball that will destroy the player! Oh no!
 * @author Sam
 */
class Fireball extends FlxSprite 
{
	public function new(?X:Float=0, ?Y:Float=0) 
	{
		super(X, Y);
		makeGraphic(16, 16, FlxColor.RED);
		velocity.set(-32, 0);
	}
}
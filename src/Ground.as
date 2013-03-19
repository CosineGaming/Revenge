package	{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Ground extends Entity	{
		
		[Embed("/../assets/ShopGround.png")] private const GROUND:Class;
		
		public function Ground()	{
			
			graphic = new Image(GROUND);
			
			collidable = false;
			
		}
		
	}
	
}
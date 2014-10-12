package 
{
	import flash.accessibility.Accessibility;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class ShopDesk extends Entity
	{
		
		[Embed(source = "/../assets/ShopDesk.png")] private const DESK:Class;
		
		public function ShopDesk()	{
			
			graphic = new Image(DESK);
			
			x = 225;
			y = 210;
			setHitbox(350, 175);
			
			type = "ShopDesk";
			
		}
		
	}
	
}
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
		
		public static var warnButton:Button = new Button(225, 210, 350, 175, warnText, null, null, null, "Button", false);
		
		public function ShopDesk()	{
			
			graphic = new Image(DESK);
			
			x = 225;
			y = 210;
			setHitbox(350, 175);
			
			type = "ShopDesk";
			
		}
		
		public static function warnText():void	{
			
			FP.world.add(new text("Use the WSAD / Arrow Keys to walk into the shop.", 175, 400, 2));
			FP.world.remove(warnButton);
			
		}
		
		override public function added():void	{
			
			FP.world.add(warnButton);
			
		}
		
	}
	
}
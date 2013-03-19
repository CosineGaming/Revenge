package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class Spotlight extends Entity	{
		
		[Embed(source = "../assets/Spotlight.png")] private const SPOTLIGHT:Class;
		
		public function Spotlight()	{
			
			graphic = new Image(SPOTLIGHT);
			
		}
		
		override public function update():void	{
			
			x = FP.world.camera.x;
			y = FP.world.camera.y;
			
		}
		
	}
	
}
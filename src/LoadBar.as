package 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class LoadBar extends Entity	{
		
		[Embed(source = "../assets/LoadBar.png")] private const BAR:Class;
		private var Bar:Image = new Image(BAR);
		
		public function LoadBar()	{
			
			graphic = Bar;
			
			x = 50;
			y = 545;
			
		}
		
		override public function update():void	{
			
			Bar.clipRect.width = Number((numLoaded + 0.0) / LoadWorld.toLoad.length) * 700.0;
			Bar.updateBuffer(true);
			
		}
		
		private function get numLoaded():Number	{
			
			var i:Number = 0;
			for (var key:String in Loaded.loaded)	{
				i += 1;
			}
			return i;
			
		}
		
	}
	
}
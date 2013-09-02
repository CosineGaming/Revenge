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
		
		private var Rect:Rectangle = new Rectangle(0, 0, 0, 30);
		private var Bar:Image = new Image(BAR);
		
		public function LoadBar()	{
			
			graphic = Bar;
			
			x = 50;
			y = 545;
			
		}
		
		override public function update():void	{
			
			Rect.width = Number((numLoaded + 0.0) / LoadWorld.toLoad.length) * 700.0;
			Bar = new Image(BAR, Rect);
			
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
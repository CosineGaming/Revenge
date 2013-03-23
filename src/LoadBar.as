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
		public static var complete:Boolean = false;
		
		public function LoadBar()	{
			
			graphic = Bar;
			
			x = 50;
			y = 545;
			
		}
		
		override public function update():void	{
			
			Rect.width = Number(numLoaded / LoadWorld.toLoad.length) * 700;
			Bar = new Image(BAR, Rect);
			if (numLoaded == LoadWorld.toLoad.length)	complete = true;
			
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
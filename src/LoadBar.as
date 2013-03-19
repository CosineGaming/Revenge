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
		private var count:Number = 0;
		
		public function LoadBar()	{
			
			graphic = Bar;
			
			x = 50;
			y = 545;
			
		}
		
		override public function update():void	{
			
			if (count > 10)	{
				count = 0;
				Rect.width = Number(Loaded.loaded.length / LoadWorld.toLoad.length) * 700;
				Bar.clipRect = Rect;
			}
			else	count += 1;
			
		}
		
	}
	
}
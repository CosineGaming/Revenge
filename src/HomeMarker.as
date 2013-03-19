package {
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class HomeMarker extends Entity	{
		
		[Embed(source = "../assets/HomeMarker.png")] private const IMAGE:Class;
		
		private var ImgSpr:Spritemap = new Spritemap(IMAGE, 15, 25);
		
		public function HomeMarker()	{
			
			ImgSpr.add("TopLeft", [0]);
			ImgSpr.add("TopRight", [1]);
			ImgSpr.add("BottomLeft", [2]);
			ImgSpr.add("BottomRight", [3]);
			
			graphic = ImgSpr;
			
		}
		
		override public function update():void	{
			
			var _x:Number = Player.statX;
			var _y:Number = Player.statY;
			var top:Boolean;
			var left:Boolean;
			if (_x < 3650)	{
				x = _x + 350;
				left = false;
			}
			else if (_x > 4350)	{
				x = _x - 350;
				left = true;
			}
			else	x = 4000;
			if (_y < 2750)	{
				y = _y + 250;
				top = false;
			}
			else if	(_y > 3250)	{
				y = _y - 250;
				top = true;
			}
			else y = 3000;
			
			if (top)	{
				if (left)	ImgSpr.play("TopLeft");
				else	ImgSpr.play("TopRight");
			}
			else	{
				if (left)	ImgSpr.play("BottomLeft");
				else	ImgSpr.play("BottomRight");
			}
			
		}
		
	}
	
}
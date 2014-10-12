package	{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.Sfx;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Button extends Entity	{
		
		private var hit:Function;
		private var mouseOver:Function;
		
		private var sound:Boolean;
		
		public function Button(INx:Number, INy:Number, INwidth:Number = -1, INheight:Number = -1, onClick:Function = null, onMouseOver:Function = null, doSound:Boolean = true, INtype:String = "Button", INimg:Class = null, clipRect:Rectangle = null)	{
			
			var buttonImage:Image;
			if (INimg)
			{
				buttonImage = new Image(INimg);
				graphic = buttonImage;
			}
			
			type = INtype;
			
			hit = onClick;
			mouseOver = onMouseOver;
			
			sound = doSound;
			
			x = INx;
			y = INy;
			if (INimg != null)	setHitbox(buttonImage.width, buttonImage.height);
			else	setHitbox(INwidth, INheight);
			
		}
		
		override public function update():void	{
			
			if (collidePoint(x, y, Input.mouseX, Input.mouseY))	{
				if (Input.mousePressed && hit != null) {
					hit();
					if (sound)	{
						h.play("other/MenuClick.mp3", false);
					}
				}
				if (mouseOver != null)	mouseOver();
			}
			
		}
		
	}
	
}
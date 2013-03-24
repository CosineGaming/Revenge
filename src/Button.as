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
		
		[Embed(source = "../assets/Blank.png")] private const BLANK:Class;
		
		private var hit:Function;
		private var mouseOver:Function;
		
		private var sound:Boolean;
		
		public function Button(INx:Number, INy:Number, INwidth:Number = -1, INheight:Number = -1, onClick:Function = null, onMouseOver:Function = null, INimg:Class = null, clipRect:Rectangle = null, INtype:String = "Button", doSound:Boolean = true)	{
			
			if (!INimg)	INimg = BLANK;
			var BUTTON:Class = INimg;
			
			if (!clipRect) clipRect = new Rectangle();
			var ImgBUTTON:Image = new Image(BUTTON, clipRect);
			
			graphic = ImgBUTTON;
			type = INtype;
			
			hit = onClick;
			mouseOver = onMouseOver;
			
			sound = doSound;
			
			x = INx;
			y = INy;
			if (INimg != BLANK)	setHitbox(ImgBUTTON.width, ImgBUTTON.height);
			else	setHitbox(INwidth, INheight);
			
		}
		
		override public function update():void	{
			
			var mouse:Entity = new Entity(Input.mouseX, Input.mouseY);
			
			if (mouse.collideWith(this, mouse.x, mouse.y))	{
				if (Input.mousePressed && hit != null) {
					hit();
					if (sound)	{
						var click:Sfx = h.getSound("other/MenuClick.mp3");
						click.play();
					}
				}
				else if (mouseOver != null)	mouseOver();
			}
			
		}
		
	}
	
}
package {
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.tweens.misc.VarTween;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Blood extends Entity	{
		
		[Embed(source = "/../assets/Blood.png")] private const BLOOD:Class;
		
		private var ASIMAGE:Image;
		
		private var fadeAt:Number;
		private var time:Number = 0;
		
		public function Blood(fade:Number=0.2)	{
			
			fadeAt = FP.elapsed + fade;
			
			ASIMAGE = new Image(BLOOD);
			graphic = ASIMAGE;
			
		}
		
		override public function update():void	{
			
			time += FP.elapsed;
			if (time > fadeAt)	{
				var disappear:VarTween = new VarTween(die);
				disappear.tween(ASIMAGE, "alpha", 0, 0.5);
				addTween(disappear, true);
			}
			
		}
		
		public function die():void	{
			FP.world.remove(this);
		}
		
	}
	
}
package	{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.misc.VarTween;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class text extends Entity	{
		
		public var TEXT:Text;
		
		private var fadeAt:Number;
		private var time:Number = 0;
		private var shouldFade:Boolean = true;
		private var goto:World;
		private var gotoFunc:Function;
		
		public function text(INtext:String, INx:Number, INy:Number, fade:Number=0, finishTo:World=null, finishToFunc:Function=null, size:Number = 16)	{
			
			fadeAt = FP.elapsed + fade;
			if (fade == false) shouldFade = false;
			TEXT = new Text(INtext);
			TEXT.size = size;
			graphic = TEXT;
			x = INx;
			y = INy;
			goto = finishTo;
			gotoFunc = finishToFunc;
			
		}
		
		override public function update():void	{
			
			time += FP.elapsed;
			if (time > fadeAt && shouldFade)	{
				var disappear:VarTween = new VarTween(die);
				disappear.tween(TEXT, "alpha", 0, 0.5);
				addTween(disappear, true);
			}
			
		}
		
		private function die():void	{
			FP.world.remove(this);
			if (goto) FP.world = goto;
			if (Boolean(gotoFunc)) gotoFunc();
		}
		
	}
	
}
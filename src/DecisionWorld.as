package	{
	import net.flashpunk.Entity;
	import net.flashpunk.Sfx;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class DecisionWorld extends World	{
		
		[Embed(source = "/../assets/Arrow.png")] private const ARROW:Class;
		
		private var oldArrow:Entity;
		private var arrowImg:Image = new Image(ARROW);
		
		private var addedList:Array = [];
		
		private var AskText:String;
		private var Options:Array;
		private var Consequences:Array;
		
		public function DecisionWorld(_AskText:String, _Options:Array, _Consequences:Array)	{
			
			var sound:String = String(h.Random(1, 3));
			
			AskText = _AskText;
			Options = _Options;
			Consequences = _Consequences;
			
		}
		
		private function mouseOver():void	{
			
			if (oldArrow)	remove(oldArrow);
			oldArrow = new Entity(75, int((Input.mouseY - 250) / 100) * 100 + 250, arrowImg);
			add(oldArrow);
			
		}
		
		override public function begin():void	{
			
			add(new text(AskText, 100, 100));
			
			add(new text("-------------------------------------------------------", 125, 175));
			
			for (var i:Number = 0; i < Options.length; i++)	{
				
				var option:text = new text(Options[i], 120, i * 100 + 250);
				add(option);
				var consequence:Button = new Button(120, i * 100 + 250, option.TEXT.width, option.TEXT.height, Consequences[i], mouseOver);
				add(consequence);
				addedList.push(option, consequence);
				
			}
			
		}
		
		override public function end():void	{
			
			if (oldArrow)	{
				
				remove(oldArrow);
				
			}
			
			for (var i:Number = 0; i < addedList.length; i++)	{
				
				remove(addedList[i]);
				
			}
			
		}
		
	}
	
}
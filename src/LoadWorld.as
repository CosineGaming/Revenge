package 
{
	import flash.events.Event;
	import flash.media.Sound;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import flash.system.Security;
	import flash.net.URLRequest;
	import net.flashpunk.FP;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class LoadWorld extends World	{
		
		[Embed(source = "../assets/Load.png")] private const LOAD:Class;
		
		public static var tips:Array = ["Tip: When you start the game, walk into the shop with WSAD keys.", "Tip: While in the Shop, you can save your progress on the right-hand side.", 
		"Tip: Dungeonike is just like Wildek... Without the villages.", "Tip: Revenge is constantly being updated. Check back later for more stuff!"]
		
		public static var toLoad:Array = ["battle/1.mp3", "battle/2.mp3", "dungeonike/1.mp3", "dungeonike/2.mp3", "dungeonike/3.mp3", "dungeonike/4.mp3", "wildek/1.mp3", "wildek/2.mp3", "menus/1.mp3", "menus/2.mp3", "menus/3.mp3", "shop/1.mp3", "shop/2.mp3", "other/MenuClick.mp3"];
		
		private var goto:World;
		
		private var origNumLoaded:Number = 0;
		
		private var timeoutID:Number;
		
		public function LoadWorld(_goto:World = null)	{
			
			goto = _goto;
			origNumLoaded = numLoaded;
			add(new Entity(0, 0, new Image(LOAD)));
			add(new LoadBar());
			timeoutID = setTimeout(finish, 30000);
			createTip();
			loadOnlineDocs();
			
		}
		
		private function createTip():void	{
			add(new text(tips[h.Random(tips.length)], 25, 300, 20, null, createTip, 18));
		}
		
		private function addToLoaded(soundName:String):Function	{
			
			return function(sound:Event):void	{
				
				var theSound:Sound = sound.target as Sound;
				Loaded.loaded[soundName] = new Sfx(theSound);
				
			};
			
		}
		
		private function load(path:String):void	{
			
			var loc:URLRequest = new URLRequest("http://www.cosinegaming.com/Revenge/resources/" + path);
			var soundNew:Sound = new Sound();
			
			soundNew.addEventListener(Event.COMPLETE, addToLoaded(path));
			soundNew.load(loc);
			
		}
		
		private function loadOnlineDocs():void	{
			
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			for (var i:Number = 0; i < toLoad.length; i++)	{
				load(toLoad[i]);
			}
			
		}
		
		private function finish():void	{
			
			clearTimeout(timeoutID);
			
			if (goto == null)	FP.world = new MenuWorld;
			
			else	FP.world = goto;
			
		}
		
		override public function update():void	{
			
			if (toLoad.length == numLoaded)	finish();
			
			super.render();
			
		}
		
		private function get numLoaded():Number	{
			
			var i:Number = 0;
			for (var key:String in Loaded.loaded)	{
				i += 1;
			}
			return i - origNumLoaded;
			
		}
		
	}
	
}
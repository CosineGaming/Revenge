package 
{
	import flash.display.Loader;
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
		
		private var gotoFunction:Function
		
		private var timeoutID:Number;
		
		private var display:text;
		
		public function LoadWorld(_goto:World = null, _gotoFunction:Function = null)	{
			
			goto = _goto;
			gotoFunction = _gotoFunction;
			add(new Entity(0, 0, new Image(LOAD)));
			add(new LoadBar());
			createTip();
			add(display);
		}
		
		public function Load(timeout:Number=20000):void	{
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			timeoutID = setTimeout(finish, timeout);
			load();
		}
		
		private function createTip():void	{
			add(new text(tips[h.Random(tips.length)], 25, 300, 5, null, createTip, 18));
		}
		
		private function addToLoaded(soundName:String):Function	{
			
			return function(sound:Event):void	{
				
				var theSound:Sound = sound.target as Sound;
				Loaded.loaded[soundName] = new Sfx(theSound);
				if (0 != toLoad.length)
					load();
				else
					finish();
				
			};
			
		}
		
		private function load():void	{
			
			var path:String = toLoad.pop();
			
			var loc:URLRequest = new URLRequest("http://www.cosinegaming.com/revenge/resources/" + path);
			var soundNew:Sound = new Sound();
			
			soundNew.addEventListener(Event.COMPLETE, addToLoaded(path));
			soundNew.load(loc);
			displayLoading(path);
			
		}
		
		private function displayLoading (path:String):void	{
			remove(display)
			display = new text(path, 25, 350);
			add(display);
		}
		
		private function finish():void	{
			
			clearTimeout(timeoutID);
			
			if (new Boolean(gotoFunction))	gotoFunction();
			
			if (goto)	FP.world = goto;
			
		}
		
	}
	
}
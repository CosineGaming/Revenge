package 
{
	import flash.events.Event;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class LoadWorld extends World	{
		
		[Embed(source = "../assets/Load.png")] private const LOAD:Class;
		
		private var tips:Array = ["When you start the game, walk into the shop with WSAD keys.", "While in the Shop, you can save your progress on the right-hand side.", 
		"Dungeonike is just like Wildek... Without the villages.", "Revenge is constantly being updated. Check back later for more stuff!"]
		
		public static var toLoad:Array = ["battle/1.mp3", "battle/2.mp3", "dungeonike/1.mp3", "dungeonike/2.mp3", "dungeonike/3.mp3", "dungeonike/4.mp3", "menus/1.mp3", "menus/2.mp3", "menus/3.mp3", "other/MenuClickle", "/.mp3"
		
		public function LoadWorld()	{
			
			add(new Entity(0, 0, new Image(LOAD));
			add(new text("Tip: " + tips[h.Random(tips.length) + 1], 50, 300, 20, null, createTip, 24));
			loadOnlineDocs();
			
		}
		
		public static function createTip():void	{
			add(new text("Tip: " + tips[h.Random(tips.length) + 1], 50, 300, 20, null, createTip, 24));
		}
		
		private function addToLoaded(sound:Event)	{
			
		}
		
		private function load(path:String)	{
			
			Security.allowDomain("*");
			Security.allowInsecureDomain("*");
			
			var loc:URLRequest = new URLRequest("http://www.cosinegaming.com/Revenge/resources/" + path);
			var soundNew:Sound = new Sound();
			
			soundNew.addEventListener(Event.COMPLETE, addToLoaded);
			soundNew.load(loc);
			
		}
		
		private function loadOnlineDocs()	{
			
			
			
		}
		
	}
	
}
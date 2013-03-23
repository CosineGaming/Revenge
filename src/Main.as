package	{
	import net.flashpunk.*;
	import splash.Splash;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Main extends Engine	{
		
		public function Main()	{
			
			super(800, 595, 40);
			
		}
		
		override public function init():void	{
			
			trace("Window successfully loaded.");
			FP.volume = 0.75;
			h.createAd();
			//createSplash();
			
		}
		
		private function createSplash():void	{
			
			var s:Splash = new Splash;
			FP.world.add(s);
			s.start(new LoadWorld);
			
		}
		
	}
	
}

/* TODO:

	 * Things to fix:
	 * Things to make better:
		 * Familiars
		 * Villages
		 * Fighting
		 * Integrate Sword and magic into fighting
		 * Dungeon downwards from Shop
	 * New features to add:
		 * Trading -- Buying and selling based on prices
		 * Make villages' battles' stakes higher
	*/

/* ChangeList:
	 * Changed Shop Image
	 * Changed Tile Numbers
	 * Changed Money Earnings
	 * Added Gold Tiles
	 * Fixed glitches with HomeMarker
	 * Fixed glitches with Shop
	 * Added Civilians in Wildek
	 * Fixed all of the glitches with not hitting things you should
	 * Made the GUIS easier to get to / navigate
	*/
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
			//h.createAd();
			createSplash();
			
		}
		
		private function createSplash():void	{
			
			var s:Splash = new Splash;
			FP.world.add(s);
			s.start(new LoadWorld);
			
		}
		
	}
	
}
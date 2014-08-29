package	{
	import net.flashpunk.*;
	import splash.Splash;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Main extends Engine	{
		
		private var loadWorld:LoadWorld = new LoadWorld(new MenuWorld);
		
		public function Main()	{
			
			super(800, 595, 48);
			
		}
		
		override public function init():void	{
			
			trace("Window successfully loaded.");
			loadWorld.Load(60000);
			FP.world = new World;
			FP.volume = 0.75;
			createSplash();
			
		}
		
		private function createSplash():void	{
			
			var s:Splash = new Splash;
			FP.world.add(s);
			s.start(loadWorld);
			
		}
		
	}
	
}
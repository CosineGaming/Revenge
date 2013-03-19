package {
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.World;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class Dungeonike extends World 	{
		
		public function Dungeonike()	{
			
			add(new DungeonikeGround);
			add(new Spotlight);
			add(new HomeMarker);
			add(new MoneyCounter);
			add(new Player(4030, 3150));
			
			camera.x = 3630;
			camera.y = 2824;
			
			name = "Dungeonike";
			
		}
		
		override public function begin():void	{
			
			h.playRand("dungeonike", 4);
			
		}
		
	}
	
}
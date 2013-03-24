package	{
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.Fader;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class MenuWorld extends World	{
		
		public function MenuWorld()	{
			
			name = "Menu";
			
			add(new Menu);
			
		}
		
		override public function begin():void	{
			
			var sound:Sfx = h.getRand("menus", 3);
			sound.volume = 0;
			sound.loop();
			var soundFader:Fader = new Fader;
			soundFader.fadeTo(0.75, 5);
			soundFader.start();
			
		}
		
	}
	
}
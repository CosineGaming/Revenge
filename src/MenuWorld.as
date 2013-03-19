package	{
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.Fader;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class MenuWorld extends World	{
		
		[Embed(source = "/../assets/sounds/menus/1.mp3")] private const s1:Class;
		[Embed(source = "/../assets/sounds/menus/2.mp3")] private const s2:Class;
		[Embed(source = "/../assets/sounds/menus/3.mp3")] private const s3:Class;
		private var sound:Sfx = [new Sfx(s1), new Sfx(s2), new Sfx(s3)][h.Random(3)];
		
		public function MenuWorld()	{
			
			name = "Menu";
			
			add(new Menu);
			
		}
		
		override public function begin():void	{
			
			sound.volume = 0;
			sound.loop();
			h.currSound = sound;
			var soundFader:Fader = new Fader;
			soundFader.fadeTo(0.75, 5);
			soundFader.start();
			
		}
		
	}
	
}
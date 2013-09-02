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
			h.playRand("menus", 3);
		}
		
	}
	
}
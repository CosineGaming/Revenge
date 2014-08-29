package	{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class ShopWorld extends World	{
		
		private static var instructions:String = 
"             Welcome to the Shop.\n\
Walk past the top or bottom of the screen to battle,\n\
    or walk into that desk in the middle there.\n\
     There you can buy upgrades to your states.\n\
  You can also buy materials to sell in villages.\n\
                  Good Luck!";
		
		public function ShopWorld(x:Number = 370, y:Number = 450)	{
			
			name = "Shop";
			
			add(new Ground);
			for (var i:Number = 0; i < h.Random(20) * Player.luck; i++)	{
				add(new Civilian);
			}
			add(new Player(x, y));
			add(new ShopDesk);
			add(new text(instructions, 175, 225, 15));
			add(new MoneyCounter);
			
			instructions = "\n\n\n\n\n\n					 Good Luck!";
			
		}
		
		override public function begin():void	{
			
			h.playRand("shop", 2);
			
		}
		
	}
	
}
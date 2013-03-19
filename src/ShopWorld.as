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
This is where you will be able to buy things and\n\
    regroup your thoughts after a long battle.\n\
   You can buy things here, and upgrade skills.\n\
 You could probably treat this kind of like your\n\
\"Home Base.\" WSAD or Arrow Keys to move. Maybe start\n\
 by walking into the Shop and getting yourself some\n\
 strength. All this traveling must have been hard !\n\
                  Good Luck!";
		
		public function ShopWorld(x:Number = 370, y:Number = 450)	{
			
			name = "Shop";
			
			add(new Ground);
			for (var i:Number = 0; i < h.Random(20); i++)	{
				add(new Civilian);
			}
			add(new Player(x, y));
			add(new ShopDesk);
			add(new text(instructions, 175, 225, 15));
			add(new MoneyCounter);
			
			instructions = "\n\n\n\n\n\n					 Good Luck!";
			
		}
		
		private function warnText():void	{
			
			FP.world.add(new text("Use the WSAD / Arrow Keys to walk into the shop.", 225, 275, 2));
			
		}
		
		override public function begin():void	{
			
			h.playRand("shop", 2);
			
		}
		
	}
	
}
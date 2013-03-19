package	{
	import flash.net.*;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Menu extends Entity	{
		
		[Embed(source = "/../assets/Menu.png")] private const GUI:Class;
		
		private var menu:Image = new Image(GUI);
		
		public function Menu()	{
			
			graphic = menu;
			
		}
		
		override public function update():void	{
			
			if (Input.mousePressed)	{
				
				if (Input.mouseY > 500)	{ // More games at CosineGaming.com
					var CosineGaming:URLRequest = new URLRequest("http://www.cosinegaming.com/");
					navigateToURL(CosineGaming);
				}
				
			}
			
		}
		
		private function newGame():void	{
			FP.world = new ShopWorld;
		}
		
		private function loadGame():void	{
			var loadObj:SharedObject = SharedObject.getLocal("RevengeSave");
			if (loadObj.data.exists)	{
				Player.upgrades = loadObj.data.upgrades;
				Player.items = loadObj.data.items;
				Player.money = loadObj.data.money;
				FP.world = new ShopWorld;
			}
			else 	{
				new text("No saved game could be found. Starting new game.", 100, 400, 5, new ShopWorld);
			}
		}
		
		override public function added():void	{
			
			var NewGameButton:Button = new Button(100, 300, 600, 50, newGame);
			var LoadGameButton:Button = new Button(100, 400, 600, 50, loadGame);
			FP.world.add(NewGameButton);
			FP.world.add(LoadGameButton);
			
		}
		
	}
	
}
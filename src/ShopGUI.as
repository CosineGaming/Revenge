package	{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class ShopGUI extends World	{
		
		[Embed(source = "/../assets/ShopGUI.png")] private const GUI:Class;
		
		private var whenDone:World;
		
		public function ShopGUI(goto:World, village:Boolean = false)	{
			
			name = "ShopGUI";
			
			whenDone = goto;
			
			var upgradePositions:Array =
				[[[50, 155], [50, 187]],
				[[155, 185], [155, 160]],
				[[315, 185], [315, 160]],
				[[465, 185], [465, 160]],
				[[615, 185], [615, 160]]];
			
			add(new Entity(0, 0, new Image(GUI)));
			
			add(new MoneyCounter);
			
			for (var i:int = 0; i < 5; i++)	{
				add (new ShopItem (upgradePositions[i][0][0], upgradePositions[i][0][1],
					upgradePositions[i][1][0], upgradePositions[i][1][1], i, false));
			}
			
			for (i = 0; i < 2; i++)	{
				var cost:uint = 100;
				if (village)
				{
					cost = h.Random(50, 150);
				}
				add (new ShopItem (i * 150 + 15, 310, i * 150 + 15, 330, i, true, false, cost));
				add (new ShopItem (i * 150 + 15, 460, i * 150 + 15, 480, i, true, true, cost));
			}
			
		}
		
		override public function update():void	{
			
			if (Input.mousePressed)	{
				
				var mouseX:int = FP.world.mouseX;
				var mouseY:int = FP.world.mouseY;
				
				if (mouseY >= 560)	{
					FP.world = whenDone;
				}
				
				if (mouseX > 750)	{
					var saveObj:SharedObject = SharedObject.getLocal("RevengeSave");
					saveObj.data.upgrades = Player.upgrades;
					saveObj.data.items = Player.items;
					saveObj.data.money = Player.money;
					saveObj.data.exists = true;
					saveObj.flush();
					add(new text("Game Saved", 10, 10, 1));
				}
				
			}
			
			super.update();
			
		}
		
	}
	
}
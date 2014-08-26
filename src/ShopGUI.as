package	{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.utils.Input;
	import flash.net.SharedObject;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class ShopGUI extends Entity	{
		
		[Embed(source = "/../assets/ShopGUI.png")] private const GUI:Class;
		
		private var itemCosts:Array = [0, 0];
		
		private var whenDone:Function = null;
		
		public function ShopGUI(village:Boolean = false, goto:Function = null)	{
			
			graphic = new Image(GUI);
			
			whenDone = goto;
			
			var upgrades:Function = function (index:int):Function	{
				return function ():Number	{
					return Player.upgrades [index];
				}
			};
			
			var upgradesSet:Function = function (index:int):Function	{
				return function (value:Number):void	{
					Player.upgrades [index] = value;
				}
			};
			
			var upgradeCost:Function = function (level:Number):Number	{
				return int(Math.pow(level, 2) + 74);
			};
			
			var upgradePositions:Array =
				[[[50, 155], [50, 187]],
				[[155, 185], [155, 160]],
				[[315, 185], [315, 160]],
				[[465, 185], [465, 160]],
				[[615, 185], [615, 160]]];
			
			for (var i:int = 0; i < 5; i++)	{
				FP.world.add (new ShopItem (upgrades(i), upgradesSet(i), upgradeCost,
					upgradePositions[i][0][0], upgradePositions[i][0][1],
					upgradePositions[i][1][0], upgradePositions[i][1][1], false));
			}
			
			if (village)	itemCosts = [h.Random(30, 170), h.Random(30, 170)];
			else	itemCosts = [100, 100];
			
			var items:Function = function (index:int):Function	{
				return function ():Number	{
					return Player.items [index];
				}
			};
			
			var itemsSet:Function = function (index:int):Function	{
				return function (value:Number):void	{
					Player.items [index] = value;
				}
			};
			
			var itemCost:Function = function (index:int):Function	{
				return function (level:Number):Number	{
					return itemCosts [index];
				}
			};
			
			for (i = 0; i < 2; i++)	{
				FP.world.add (new ShopItem (items(i), itemsSet(i), itemCost(i),
					i * 150 + 15, 310, i * 150 + 15, 330, true));
				FP.world.add (new ShopItem (items(i), itemsSet(i), itemCost(i),
					i * 150 + 15, 460, i * 150 + 15, 480, true, true));
			}
			
		}
		
		override public function update():void	{
			
			if (Input.mousePressed)	{
				
				var mouseX:int = FP.world.mouseX;
				var mouseY:int = FP.world.mouseY;
				
				if (mouseY >= 560)	{
					FP.world.remove(this); // Exit
					if (whenDone != null)	whenDone();
				}
				
				if (mouseX > 750)	{
					var saveObj:SharedObject = SharedObject.getLocal("RevengeSave");
					saveObj.data.upgrades = Player.upgrades;
					saveObj.data.items = Player.items;
					saveObj.data.money = Player.money;
					saveObj.data.exists = true;
					saveObj.flush();
					FP.world.add(new text("Game Saved", 10, 10, 1));
				}
				
			}
			
		}
		
	}
	
}
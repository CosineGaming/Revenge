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
		
		private var ITEMCOSTS:Array = [0, 0];
		
		private var whenDone:Function = null;
		
		private function get ITEMCOSTSTRS():Array	{
			var toReturn:Array = [];
			for (var i:Number = 0; i < ITEMCOSTS.length; i++)	{
				toReturn.push(String(ITEMCOSTS[i]) + " GP");
			}
			return toReturn;
		}
		
		private function cost(level:Number):Number	{
			return int(Math.pow(level, 2) + 74);
		}
		
		private function get UPGRADECOSTS():Array	{
			var toReturn:Array = [];
			for (var i:Number = 0; i < Player.upgrades.length; i++ )	{
				toReturn.push(cost(Player.upgrades[i]));
			}
			return toReturn;
		}
		
		private function get LEVELSTRS():Array 	{
			var toReturn:Array = [];
			for (var i:Number = 0; i < Player.upgrades.length; i++)	{
				toReturn.push("LVL " + String(Player.upgrades[i]));
			}
			return toReturn;
		}
		
		private function get UPGRADESTRS():Array	{
			var toReturn:Array = [];
			for (var i:Number = 0; i < UPGRADECOSTS.length; i++)	{
				toReturn.push(String(UPGRADECOSTS[i]) + " GP");
			}
			return toReturn;
		}
		
		private function get OWNEDSTRS():Array	{
			var toReturn:Array = [];
			for (var i:Number = 0; i < Player.items.length; i++)	{
				toReturn.push(String(Player.items[i]) + " Owned");
			}
			return toReturn;
		}
		
		private var texts:Array;
		
		public function ShopGUI(village:Boolean = false, goto:Function = null)	{
			
			graphic = new Image(GUI);
			
			if (village)	ITEMCOSTS = [h.Random(0, 200), h.Random(0, 200)];
			else	ITEMCOSTS = [100, 100];
			
			whenDone = goto;
			
			texts = [
				new text(UPGRADESTRS[0], 50, 187), new text(LEVELSTRS[0], 50, 155), 
				new text(UPGRADESTRS[1], 155, 160), new text(LEVELSTRS[1], 155, 185),
				new text(UPGRADESTRS[2], 315, 160), new text(LEVELSTRS[2], 315, 185),
				new text(UPGRADESTRS[3], 465, 160), new text(LEVELSTRS[3], 465, 185),
				new text(UPGRADESTRS[4], 615, 160), new text(LEVELSTRS[4], 615, 185),
				new text(ITEMCOSTSTRS[0], 15, 310), new text(ITEMCOSTSTRS[1], 165, 310),
				new text(ITEMCOSTSTRS[0], 15, 460), new text(ITEMCOSTSTRS[1], 165, 460),
				new text(OWNEDSTRS[0], 15, 330), new text(OWNEDSTRS[1], 165, 330),
				new text(OWNEDSTRS[0], 15, 480), new text(OWNEDSTRS[1], 165, 480)];
			
		}
		
		public function updateTexts():void	{
			
			for (var i:Number = 0; i < texts.length; i++)	{
				FP.world.remove(texts[i]);
			}
			
			texts = [
				new text(UPGRADESTRS[0], 50, 187), new text(LEVELSTRS[0], 50, 155), 
				new text(UPGRADESTRS[1], 155, 160), new text(LEVELSTRS[1], 155, 185),
				new text(UPGRADESTRS[2], 315, 160), new text(LEVELSTRS[2], 315, 185),
				new text(UPGRADESTRS[3], 465, 160), new text(LEVELSTRS[3], 465, 185),
				new text(UPGRADESTRS[4], 615, 160), new text(LEVELSTRS[4], 615, 185),
				new text(ITEMCOSTSTRS[0], 15, 310), new text(ITEMCOSTSTRS[1], 165, 310),
				new text(ITEMCOSTSTRS[0], 15, 460), new text(ITEMCOSTSTRS[1], 165, 460),
				new text(OWNEDSTRS[0], 15, 330), new text(OWNEDSTRS[1], 165, 330),
				new text(OWNEDSTRS[0], 15, 480), new text(OWNEDSTRS[1], 165, 480)];
			
			for (i = 0; i < texts.length; i++)	{
				FP.world.add(texts[i]);
			}
			
		}
		
		override public function update():void	{
			
			if (Input.mousePressed)	{
				
				var mouseX:int = FP.world.mouseX;
				var mouseY:int = FP.world.mouseY - 105; // Compensates for the part that says SHOP
				
				var buttonX:int = mouseX / 150;  // The size of a tile is 150
				var buttonY:int = mouseY / 150;
				if (mouseY < 0) buttonY = -1; // Solve an issue with rounding up to zero.
				if (mouseY >= 455)	{
					FP.world.remove(this); // Exit
				}
				
				
				if (buttonX == 5)	{
					var saveObj:SharedObject = SharedObject.getLocal("RevengeSave");
					saveObj.data.upgrades = Player.upgrades;
					saveObj.data.items = Player.items;
					saveObj.data.money = Player.money;
					saveObj.data.exists = true;
					saveObj.flush();
					FP.world.add(new text("Game Saved", 10, 10, 1));
				}
				else	{
				
					var ITEM:int;
					
					switch(buttonY)	{
						case 0: // Upgrades
						{
							var UPGRADE:int = buttonX;
							if (Player.money >= UPGRADECOSTS[UPGRADE])	{
								
								Player.money -= UPGRADECOSTS[UPGRADE];
								
								Player.increaseUpgrade(UPGRADE, 1);
								
								if (UPGRADE == 2)	FP.world.add(new text("Hold TAB to temporarily go slowly.", 10, 10, 2));
								
							}
							else	FP.world.add(new text("Bud, you don't got the Gold!", 10, 10, 2));
							break;
						}
						case 1: // Buy items
						{
							ITEM = buttonX;
							if (Player.money >= ITEMCOSTS[ITEM])	{
								Player.money -= ITEMCOSTS[ITEM];
								Player.items[ITEM] += 1;
							}
							else if (Player.items[ITEM] != null)	FP.world.add(new text("Bud, you don't got the Gold!", 10, 10, 2));
							break;
						}
						case 2: // Sell items
						{
							ITEM = buttonX;
							if (Player.items[ITEM] > 0)	{
								Player.money += ITEMCOSTS[ITEM];
								Player.items[ITEM] -= 1;
							}
							else if (Player.items[ITEM] != null)	FP.world.add(new text("Bud, you don't got none!", 10, 10, 2));
							break;
						}
					}
					
					updateTexts();
				
				}
				
			}
			
		}
		
		override public function added():void {
			
			for (var i:Number = 0; i < texts.length; i++)	{
				FP.world.add(texts[i]);
			}
			
		}
		
		override public function removed():void	{
			
			for (var i:Number = 0; i < texts.length; i++)	{
				FP.world.remove(texts[i]);
			}
			
			if (whenDone != null)	whenDone();
			
		}
		
	}
	
}
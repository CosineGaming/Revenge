package
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class ShopItem extends Entity	{
		
		private var index:uint;
		
		private var item:Boolean;
		
		private var addMoney:Boolean;
		
		private var positions:Array;
		
		private var texts:Graphiclist;
		
		private var itemCost:uint;
		
		private var reference:Array;
		
		private function get cost():uint	{
			if (item)
			{
				return itemCost;
			}
			else 
			{
				return int(Math.pow(reference[index], 2) + 74);	
			}
		}
		
		private function get costString():String	{
			return String(cost) + " GP";
		}
		
		private function get ownedString():String	{
			return String(reference[index]) + " Owned";
		}
		
		private function get levelString():String	{
			return "LVL " + String(reference[index]);
		}
		
		public function ShopItem(levelX:Number, levelY:Number, costX:Number, costY:Number,
			elementIndex:uint, isItem:Boolean, sell:Boolean = false, ifItemCost:uint = 0)	{
			
			item = isItem;
			addMoney = sell;
			index = elementIndex;
			
			x = int((levelX) / 150) * 150;
			y = int((levelY - 105) / 150) * 150 + 105;
			setHitbox(150, 150);
			positions = [levelX - x, levelY - y, costX - x, costY - y];
			
			if (item)
			{
				reference = Player.items;
				itemCost = ifItemCost;
			}
			else
			{
				reference = Player.upgrades;
			}
			
			layer = -1;
			
			texts = new Graphiclist(new Text(costString, positions [2], positions [3]));
			if (item)	texts.add(new Text(ownedString, positions [0], positions [1]));
			else	texts.add(new Text(levelString, positions [0], positions [1]));
			
			graphic = texts;
			
		}
		
		override public function update():void	{
			
			if (Input.mousePressed)	{
				
				if (FP.world.mouseY > 560)	{
					FP.world.remove(this);
				}
				
				if (collidePoint(x, y, FP.world.mouseX, FP.world.mouseY))	{
					
					trace(this.x, ", ", this.y);
					
					if (Input.check(Key.SHIFT))	{
						
						if (addMoney)	{
							
							if (reference[index] > 0)	{
								Player.money += cost * reference[index];
								reference[index] = 0;
							}
							else	{
								FP.world.add(new text("Bud, you don't got none!", 10, 10, 2));
							}
							
						}
						else	{
							
							if (Player.money > cost)	{
								reference[index] += int(Player.money / cost);
								Player.money %= cost;
							}
							else	{
								FP.world.add(new text("Bud, you don't got the Gold!", 10, 10, 2));
							}
							
						}
						
					}
					
					else	{
						
						if (addMoney)	{
							
							if (reference[index] > 0)	{
								reference[index] -= 1;
								Player.money += cost;
							}
							else	{
								FP.world.add(new text("Bud, you don't got none!", 10, 10, 2));
							}
							
						}
						else	{
							
							if (Player.money >= cost)	{
								Player.money -= cost;
								reference[index] += 1;
							}
							else	{
								FP.world.add(new text("Bud, you don't got the Gold!", 10, 10, 2));
							}
							
						}
						
					}
					
				}
				
			}
			
			texts.removeAll();
			texts.add(new Text(costString, positions [2], positions [3]));
			if (item)	texts.add(new Text(ownedString, positions [0], positions [1]));
			else	texts.add(new Text(levelString, positions [0], positions [1]));
			
		}
		
	}
	
}
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
		
		public var levelFormula:Function;
		
		public var levelFormulaSet:Function;
		
		public var costFormula:Function;
		
		public var renderOwned:Boolean;
		
		public var addMoney:Boolean;
		
		public var positions:Array;
		
		public var texts:Graphiclist;
		
		public function get level():Number	{
			return levelFormula();
		}
		
		public function get cost():Number	{
			return costFormula(level);
		}
		
		public function get costString():String	{
			return String(cost) + " GP";
		}
		
		public function get ownedString():String	{
			return String(level) + " Owned";
		}
		
		public function get levelString():String	{
			return "LVL " + String(level);
		}
		
		public function ShopItem(levelFunction:Function, levelFunctionSet:Function, costFunction:Function,
			levelX:Number, levelY:Number, costX:Number, costY:Number, isItem:Boolean, sell:Boolean=false)	{
			
			levelFormula = levelFunction;
			levelFormulaSet = levelFunctionSet;
			costFormula = costFunction;
			renderOwned = isItem;
			
			x = int((levelX) / 150) * 150;
			y = int((levelY - 105) / 150) * 150 + 105;
			setHitbox(150, 150);
			positions = [levelX - x, levelY - y, costX - x, costY - y];
			addMoney = sell;
			
			layer = -1;
			
			texts = new Graphiclist(new Text(costString, positions [2], positions [3]));
			if (isItem)	texts.add(new Text(ownedString, positions [0], positions [1]));
			else	texts.add(new Text(levelString, positions [0], positions [1]));
			
			graphic = texts;
			
		}
		
		override public function update():void	{
			
			if (Input.mousePressed)	{
				
				if (FP.world.mouseY > 560)	{
					FP.world.remove(this);
				}
				
				if (collideWith(this, FP.world.mouseX, FP.world.mouseY))	{
					
					if (Input.check(Key.SHIFT))	{
						
						if (addMoney)	{
							
							if (level > 0)	{
								Player.money += cost * level;
								levelFormulaSet (0);
							}
							else	{
								FP.world.add(new text("Bud, you don't got none!", 10, 10, 2));
							}
							
						}
						else	{
							
							if (Player.money > cost)	{
								levelFormulaSet (level + int(Player.money / cost));
								Player.money %= cost;
							}
							else	{
								FP.world.add(new text("Bud, you don't got the Gold!", 10, 10, 2));
							}
							
						}
						
					}
					
					else	{
						
						if (addMoney)	{
							
							if (level > 0)	{
								levelFormulaSet (level - 1);
								Player.money += cost;
							}
							else	{
								FP.world.add(new text("Bud, you don't got none!", 10, 10, 2));
							}
							
						}
						else	{
							
							if (Player.money > cost)	{
								Player.money -= cost;
								levelFormulaSet (level + 1);
							}
							else	{
								FP.world.add(new text("Bud, you don't got the Gold!", 10, 10, 2));
							}
							
						}
						
					}
					
				}
				
				texts.removeAll();
				texts.add(new Text(levelString, positions [0], positions [1]));
				if (addMoney)	texts.add(new Text(ownedString, positions [0], positions [1]));
				else	texts.add(new Text(levelString, positions [0], positions [1]));
				
			}
			
		}
		
	}
	
}
package
{
	import net.flashpunk.FP;
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class ShopItem extends Entity	{
		
		public var levelFormula:Function;
		
		public var levelFormulaSet:Function;
		
		public var costFormula:Function;
		
		public var renderOwned:Boolean;
		
		public var positions:Array;
		
		public var texts:Graphiclist;
		
		public function get level():Number	{
			return levelFormula();
		}
		
		public function get cost():Number	{
			return costFormula(level);
		}
		
		public function get costString():Number	{
			return String(cost) + " GP";
		}
		
		public function get ownedString():Number	{
			return String(cost) + " Owned";
		}
		
		public function get levelString():Number	{
			return "LVL " + String(level);
		}
		
		public function ShopItem(levelFunction:Function, levelFunctionSet:Function, costFunction:Function,
			levelX:Number, levelY:Number, costX:Number, costY:Number, isItem:Boolean)	{
			
			levelFormula = levelFunction;
			levelFormulaSet = levelFunctionSet;
			costFormula = costFunction;
			renderOwned = isItem;
			
			graphic = texts;
			x = int((levelX) / 150) * 150;
			y = int((levelY - 105) / 150) * 150 + 105;
			setHitbox(150, 150);
			positions = [levelX - x, levelY - y, costX - x, costY - y];
			
			texts.add(new Text(levelString, positions [0], positions [1]));
			texts.add(new Text(costString, positions [2], positions [3]));
			
		}
		
		override public function update():void	{
			
			texts.removeAll();
			texts.add(new Text(levelString, positions [0], positions [1]));
			texts.add(new Text(costString, positions [2], positions [3]));
			
		}
		
	}
	
}
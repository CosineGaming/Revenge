package	{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author Cosine Gaming
	 */
	
	public class WildekGround extends Entity	{
		
		[Embed(source = "/../assets/WildekGround.png")] private const GROUND:Class;
		
		/**
		 * 0 = Normal
		 * 1 = Shop
		 * 2 = Orb
		 * 3 = Evil
		 * 4 = Gold
		 * 5 = Village
		 * 6 = Mountain 1
		 * 7 = Mountain 2
		 * 8 = Lake
		 * 9 = Gate
		 */
		public static var tilemap:Tilemap;
		public static var grid:Grid = new Grid(8000, 6000, 100, 100, 0, 0);
		
		public function WildekGround()	{
			
			tilemap = new Tilemap(GROUND, 8000, 6000, 100, 100);
			
			graphic = tilemap;
			mask = grid;
			
			tilemap.setRect(0, 0, 80, 60, 0); // Grass field
			
			for (var i:Number = 0; i < h.Random(400 * Player.luck); i++)	{ // Lay Mountain ranges and Lakes randomly throughout Wildek
				var column:Number = h.Random(0, 80);
				var row:Number = h.Random(0, 60);
				var mountainRange:Boolean = h.Random(0, 2);
				if (mountainRange)	{
					for (var b:Number = 0; b < h.Random(8 * Player.luck); b++)	{
						tilemap.setTile(column, row, h.Random(6, 8));
						column += h.Random(0, 2) * 2 - 1; // Move left or right 1
						row += h.Random(0, 2) * 2 - 1; // Move up or down 1
					}
				}
				else	{
					tilemap.setTile(column, row, 8);
				}
			}
			
			for (i = 0; i < h.Random(1000 * Player.luck); i++)	{ // Add evil, orb, gold, and village grass
				tilemap.setTile(h.Random(0, 81), h.Random(0, 61), h.Random(2, 6));
			}
			tilemap.setTile(40, 30, 1); // Add Back to Shop tile
			
			for (i = 3; i < 77; i++)	{
				var max:uint = h.Random(1, 5);
				for (var upto:int = h.Random(-3, 1); upto < max; ++upto)
				{
					tilemap.setTile(i, 3 + upto, h.Random(6, 9));
					tilemap.setTile(i, 56 + upto, h.Random(6, 9));
				}
			}
			for (i = 3; i < 57; i++)	{
				var max:uint = h.Random(0, 4);
				for (var upto:int = h.Random(-3, 1); upto < max; ++upto)
				{
					tilemap.setTile(3 + upto, i, h.Random(6, 9));
					tilemap.setTile(76 + upto, i, h.Random(6, 9));
				}
			}
			tilemap.setTile(39, 3, 9); // Add Gate out of Wildek
			
			tilemap.createGrid([1, 2, 3, 4, 5, 6, 7, 8, 9], grid);
			
			type = "WildekGround";
			
		}
		
	}
	
}
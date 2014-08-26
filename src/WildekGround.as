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
						column += h.Random(-1, 2);
						row += h.Random(-1, 2);
					}
				}
				else	{
					tilemap.setTile(column, row, 8);
				}
			}
			
			for (i = 0; i < h.Random(1000 * Player.luck); i++)	{ // Add evil orb and gold grass along with villages around the edges
				column = h.Random(3, 77);
				row = h.Random(3, 57);
				var tile:Number;
				if (h.Random(0, 6) != 0)	tile = h.Random(2, 5); // Not a village
				else	tile = h.Random(2, 6);
				tilemap.setTile(column, row, tile);
			}
			tilemap.setTile(40, 30, 1); // Add Back to Shop tile
			
			var canBeLake:Boolean = h.Random(0, 8) == 0; // Lay Mountains / Lakes preventing exit of Wildek
			for (i = 3; i < 77; i++)	{
				tilemap.setTile(i, 3, canBeLake ? h.Random(6, 9) : h.Random(6, 8));
				tilemap.setTile(i, 56, canBeLake ? h.Random(6, 9) : h.Random(6, 8));
			}
			for (i = 3; i < 57; i++)	{
				tilemap.setTile(3, i, canBeLake ? h.Random(6, 9) : h.Random(6, 8));
				tilemap.setTile(76, i, canBeLake ? h.Random(6, 9) : h.Random(6, 8));
			}
			tilemap.setTile(39, 3, 9); // Add Gate out of Wildek
			
			tilemap.createGrid([1, 2, 3, 4, 5, 6, 7, 8, 9], grid);
			
			type = "WildekGround";
			
		}
		
	}
	
}
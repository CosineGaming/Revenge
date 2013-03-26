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
		 * 0 = Normal Grass
		 * 1 = Orb Grass
		 * 2 = Evil Grass
		 */
		public static var tilemap:Tilemap;
		public static var grid:Grid = new Grid(8000, 6000, 100, 100, 0, 0);
		
		public function WildekGround()	{
			
			tilemap = new Tilemap(GROUND, 8000, 6000, 100, 100);
			
			graphic = tilemap;
			mask = grid;
			
			tilemap.setRect(0, 0, 80, 60, 0);
			
			for (var i:Number = 0; i < h.Random(1000 * Player.luck); i++)	{
				var column:Number = h.Random(0, 80);
				var row:Number = h.Random(0, 60);
				var tile:Number;
				if (column > 2 && column < 77 && row > 2 && row < 57)	tile = h.Random(2, 5);
				else	tile = h.Random(2, 6);
				tilemap.setTile(column, row, tile);
			}
			tilemap.setTile(40, 30, 1);
			
			tilemap.createGrid([1, 2, 3, 4, 5], grid);
			
			type = "WildekGround";
			
		}
		
	}
	
}
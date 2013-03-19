package {
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Tilemap;
	import net.flashpunk.masks.Grid;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class DungeonikeGround extends Entity	{
		
		[Embed(source = "../assets/DungeonikeGround.png")] private const GROUND:Class;
		
		/**
		 * 0 = Normal Grass
		 * 1 = Orb Grass
		 * 2 = Evil Grass
		 */
		public static var tilemap:Tilemap;
		public static var grid:Grid = new Grid(8000, 6000, 100, 100, 0, 0);
		
		public function DungeonikeGround()	{
			
			tilemap = new Tilemap(GROUND, 8000, 6000, 100, 100);
			
			graphic = tilemap;
			mask = grid;
			
			tilemap.setRect(0, 0, 80, 60, 0);
			
			for (var i:Number = 0; i < h.Random(1000 * Player.luck); i++)	{
				var column:Number = h.Random(0, 80);
				var row:Number = h.Random(0, 60);
				tilemap.setTile(column, row, h.Random(2, 5));
			}
			tilemap.setTile(40, 30, 1);
			
			tilemap.createGrid([1, 2, 3, 4], grid);
			
			type = "DungeonikeGround";
			
		}
		
	}
	
}
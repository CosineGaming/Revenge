package 
{
	
	/**
	 * Get the x and y for traveling from one place to another at a certain speed
	 * @author Christopher Phonis-Phine
	 */
	public class hVector	{
		
		public var x:Number;
		public var y:Number;
		
		public function hVector(INx:Number, INy:Number, INspeed:Number)	{
			
			var hyp:Number = INx * INx * INy * INy;
			var opp:Number = INx;
			var adj:Number = INy;
			
			var speed:Number = INspeed;
			var angle:Number = Math.acos(adj / hyp);
			
			x = Math.sin(angle) * speed;
			y = Math.cos(angle) * speed;
			
		}
		
	}
	
}
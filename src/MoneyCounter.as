package { 
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Text;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class MoneyCounter extends Entity	{
		
		private var oldMoney:Number = 0;
		
		public function MoneyCounter()	{
			
			graphic = new Text(Player.money + " GP");
			
			x = 10;
			y = 570;
			
			layer = -10;
			
		}
		override public function update():void	{
			
			if (Player.money != oldMoney)	{
				graphic = new Text(Player.money + " GP");
				oldMoney = Player.money;
			}
			
			if (FP.world.camera.x != 0 || FP.world.camera.y != 0)	{
				x = Player.statX - 360;
				y = Player.statY + 303;
			}
			
		}
		
	}
	
}
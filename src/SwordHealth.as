package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Image;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SwordHealth extends Entity {
		
		[Embed(source = "../assets/HealthBar.png")] private var healthBar:Class;
		
		public var health:Number;
		
		public var level:uint;
		
		public var move:Array;
		
		private var player:Boolean;
		
		private var tempOther:Object;
		private var other:SwordHealth;
		
		private var bar:Image;
		
		public function turn(fromLeft:uint, fromTop:uint):void {
			
			move = [fromLeft, fromTop];
			
			// Enemy's AI:
			other.move = move; // IDIOT for now, later I'll implement legits
			
		}
		
		public function endTurn():void {
			
			if (move[0] == 0)
			{
				// Aggressive move
				var type:uint = move[1];
				if (type == 0)
				{
					// Stab
					if (other.move != [1, 0])
					{
						// Goes through
						other.health -= 1;
					}
					else 
					{
						// Blocked... probably
					}
				}
				else
				{
					// Swing
					if (other.move != [1, 1])
					{
						// Goes through
						other.health -= 2;
					}
					else
					{
						// Blocked... probably
					}
				}
			}
			if (player)
			{
				// Enemy ends his turn
				other.endTurn();
			}
			
		}
		
		public function SwordHealth(otherRef:Object, isPlayer:Boolean) {
			
			player = isPlayer;
			
			tempOther = otherRef;
			
			bar = new Image(healthBar);
			graphic = bar;
			
		}
		
		override public function added():void {
			
			other = tempOther.sword;
			
		}
		
		override public function update():void {
			
			bar.clipRect.right = health / level * 200;
			bar.updateBuffer(true);
			
		}
		
	}
	
}
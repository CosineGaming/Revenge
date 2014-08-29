package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author Cosine Gaming
	 */
	public class MagicPanel extends Entity
	{
		
		private var otherHandle:Object;
		
		public var other:MagicPanel;
		
		public var list:Array;
		
		public var health:Number;
		
		public var mana:Number;
		
		public var level:uint;
		
		private var enemy:Boolean;
		
		private var enemyCountdown:Number;
		
		private var graphics:Graphiclist;
		
		// Otherside must contain otherSide.panel:MagicPanel which is the other panel
		public function MagicPanel(player:Boolean, otherSide:Object, customLevel:uint = 0)
		{
			x = uint(player) * 750;
			y = 0;
			
			enemy = !player;
			otherHandle = otherSide;
			
			if (player)
			{
				level = Player.magic;
			}
			else 
			{
				level = customLevel;
			}
			health = 2 * level;
			mana = 2 * level;
			
			enemyCountdown = 1;
			
			graphics = new Graphiclist;
			graphic = graphics;
			
			list = new Array;
		}
		
		override public function added():void
		{
			other = otherHandle.panel;
		}
		
		private function fire():void
		{
			if (mana >= list[0] % 100)
			{
				mana -= list[0] % 100;
				if (other.list.length)
				{
					if (Math.abs(list[0] - other.list[0]) == 100)
					{
						// One defends against the other
						other.list.shift();
					}
					else if (list[0] < 100)
					{
						// Attacking
						other.health -= list[0];
					}
				}
				else
				{
					if (list[0] < 100)
					{
						// Attacking against nothing
						other.health -= list[0];
					}
				}
				list.shift();
			}
		}
		
		override public function update():void
		{
			
			graphics.removeAll();
			var settings:Object = new Object;
			settings.size = 45;
			for (var i:uint = 0; i < list.length; ++i)
			{
				if (list[i] < 10)
				{
					settings.color = 0xFF0000;
				}
				else
				{
					settings.color = 0x00FF00;
				}
				graphics.add(new Text(String(list[i] % 100), 5, 55 + i * 50, settings));
			}
			
			health += level * 2 / 40.0 * FP.elapsed;
			mana += level * 2 / 25.0 * FP.elapsed;
			if (health > level * 2)
			{
				health = level * 2
			}
			if (mana > level * 2)
			{
				mana = level * 2;
			}
			
			if (enemy)
			{
				// AI
				enemyCountdown -= FP.elapsed;
				if (enemyCountdown <= 0)
				{
					enemyCountdown = h.Random(1, 26) / 20.0;
					var maxSpell = uint(Math.sqrt(level));
					if (list.length == 0)
					{
						// We're empty
						if (other.list.length)
						{
							// They have something prepared for us
							if (other.list.length && other.list[0] <= maxSpell * 2)
							{
								// Defend against them
								list.push(other.list[0] + 100);
							}
							else 
							{
								// They're so much better we can't defend. Agressive move
								// Or they're empty
								var spell:uint = maxSpell;
								if (other.list[0] == spell + 100)
								{
									// This one's defended, choose next best one
									spell -= 1;
								}
								list.push(spell);
							}
						}
						else 
						{
							// They're not prepared. Give 'em hell, boys!
							list.push(maxSpell);
						}
					}
					else 
					{
						// We have moves queued
						if (other.list.length)
						{
							// So do they
							if (other.list[0] + 100 == list[0])
							{
								// We have a defense set up, should stay banked. Keep queueing.
								if (other.list.length > list.length)
								{
									var noAggressive:Boolean = true;
									for (var item:uint = 0; item < list.length; ++item)
									{
										if (list[item] < 100)
										{
											noAggressive = false;
											break;
										}
									}
									if (noAggressive && other.list[list.length] < 100)
									{
										// Defend against them, keep our queue matched with theirs
										list.push(other.list[list.length] + 100);
									}
									else 
									{
										// Our queues disconnet at some point, queue aggressively.
										list.push(maxSpell);
									}
								}
							}
							else
							{
								// Let's try to defeat them
								fire();
							}
						}
						else
						{
							// They don't. Let 'em have it.
							fire();
						}
					}
				}
			}
			
			if (Input.pressed(Key.SPACE) && !enemy)
			{
				fire()
			}
			
		}
		
	}
	
}
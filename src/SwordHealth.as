package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author ...
	 */
	public class SwordHealth extends Entity {
		
		[Embed(source = "../assets/HealthBar.png")] private var healthBar:Class;
		
		public var health:Number;
		
		public var stamina:uint;
		
		public var level:uint;
		
		public var move:Array;
		
		private var player:Boolean;
		
		private var tempOther:Object;
		private var other:SwordHealth;
		
		private var bar:Image;
		
		private var finish:World;
		
		private var oldText:text;
		
		public function turn(fromLeft:uint, fromTop:uint):void {
			
			move = [fromLeft, fromTop];
			
			// Enemy's AI:
			other.move = [h.Random(0, 2), h.Random(0, 2)]; // IDIOT for now, later I'll implement legits
			
		}
		
		public function endTurn():Boolean {
			
			var description:String = "";
			if (move[0] == 0)
			{
				// Aggressive move
				var type:uint = move[1];
				if (type == 0)
				{
					// Stab
					if (other.move[0] == 1 && other.move[1] == 0)
					{
						// Blocked... probably
						if (player)
						{
							description = "You stab the enemy, but he is prepared for you!\nHe dodges, rendering your attack useless!";
						}
						else 
						{
							description = "The enemy stabs toward you, but you saw it coming!\nYou dodge him, predicting his actions!";
						}
					}
					else 
					{
						// Goes through
						other.health -= 1;
						if (player)
						{
							description = "You stab the unsuspecting enemy and deal 1 damage!";
						}
						else 
						{
							description = "The enemy stabs you as you look elsewhere and deals 1 damage!";
						}
					}
				}
				else
				{
					// Swing
					if (other.move[0] == 1 && other.move[1] == 1)
					{
						// Blocked... probably
						if (player)
						{
							description = "Though you swing at the enemy, he has a powerful parry!\nAll that happens is a loud clang of metal!";
						}
						else
						{
							description = "The enemy swings at you, but you parry powerfully!\nA loud clang rings in the air and both swords seperate!";
						}
					}
					else
					{
						// Goes through
						other.health -= 2;
						if (player)
						{
							description = "You swing at the enemy with utter power and deal 2 damage!";
						}
						else 
						{
							description = "The enemy swings at you too quickly for you to notice!\nHe swings right into your ribs and deals 2 damage!";
						}
					}
				}
			}
			
			if (oldText)
			{
				FP.world.remove(oldText);
			}
			if (description)
			{
				oldText = new text(description, 300, 50 + int(player) * 40, 0, null, null, 12);
				FP.world.add(oldText);
			}
			
			var killed:Boolean = false;
			if (player)
			{
				// Enemy ends his turn
				killed = other.endTurn();
			}
			
			if (health <= 0 && !killed)
			{
				var target:uint = Math.sqrt(other.level) * 225;
				var gold:Number = h.Random(target * 0.5, target * 1.5);
				var item:Number = -1;
				if (gold > Player.money)
				{
					gold = Player.money;
					if (Player.items[0])
					{
						item = 0;
					}
					else if (Player.items[1])
					{
						item = 1;
					}
				}
				var words:String;
				if (player)
				{
					Player.money -= gold;
					words = "The enemy stabs his sword playfully into your gurgling, bleeding throat,\nand walks away with " + (Player.money == 0 ? "all " : "") + String(gold) + " of your Gold.";
					if (item != -1)
					{
						words += "\nThe enemy also takes all " + String(Player.items[item]) + " of your " + ["wood", "metal"][item] + ".";
					}
				}
				else 
				{
					Player.money += gold;
					words = "You search the enemy's eviscerated body\nand take " + String(gold) + " of the their Gold.";
				}
				if (Player.money != 0)
				{
					words += "\nYou now have " + String(Player.money) + " Gold.";
				}
				FP.world.add(new text(words, 100, 100, 4, finish));
				FP.world.remove(other);
				return true;
			}
			
			return false;
			
		}
		
		public function SwordHealth(otherRef:Object, isPlayer:Boolean, isStamina:Boolean, finishTo:World, customLevel:uint=0) {
			
			player = isPlayer;
			
			tempOther = otherRef;
			
			bar = new Image(healthBar);
			graphic = bar;
			
			x = 10 + 580 * int(isPlayer);
			y = 22;
			
			if (isPlayer)
			{
				level = Player.sword;
			}
			else 
			{
				level = customLevel;
			}
			health = 2 * level;
			
			finish = finishTo;
			
		}
		
		override public function added():void {
			
			other = tempOther.sword;
			
		}
		
		override public function update():void {
			
			bar.clipRect.right = health / level / 2 * 200;
			bar.updateBuffer(true);
			
		}
		
	}
	
}
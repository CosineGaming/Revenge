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
		
		public var move:Number;
		
		private var player:Boolean;
		
		private var tempOther:Object;
		private var other:SwordHealth;
		
		private var bar:Image;
		
		private var finish:World;
		
		private var oldText:text;
		
		public function turn(moveType:uint):void {
			
			move = moveType;
			
			// Enemy's AI:
			other.move = h.Random(0, 3); // IDIOT for now, later I'll implement legits (TODO)
			
		}
		
		public function endTurn():Boolean {
			
			var description:String = "";
			var power:uint = h.Random(1, level + 1);
			if (move == 0)
			{
				// Stab
				if (other.move == 2)
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
					other.health -= power;
					if (player)
					{
						description = "You stab the unsuspecting enemy and deal " + String(power) + " damage!";
					}
					else 
					{
						description = "The enemy stabs you as you look elsewhere and deals " + String(power) + " damage!";
					}
				}
			}
			else if (move == 1)
			{
				// Swing
				if (other.move == 2)
				{
					// Blocked... probably
					if (player)
					{
						description = "Though you swing at the enemy, he quickly flits away!\nYou merely lose your balance!";
					}
					else
					{
						description = "The enemy swings at you, but you duck it expertly!\nYou hear wooshing over your head!";
					}
				}
				else if (other.move == 1)
				{
					// Blocked... probably
					if (player)
					{
						description = "You both slash at each other, creating a strong perry! A loud clang of metal rings in the air!";
					}
					// Merely need to describe once as both perry in this situation
				}
				else
				{
					// Goes through
					other.health -= power * 2;
					if (player)
					{
						description = "You swing at the enemy with utter power and deal " + String(power) + " damage!";
					}
					else 
					{
						description = "The enemy swings at you too quickly for you to notice!\nHe swings right into your ribs and deals " + String(power) + " damage!";
					}
				}
			}
			// Only deal with aggressive moves
			
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
			
			// TODO: If killed, then what?
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
				FP.world.add(new text(words, 100, 100, 8, finish));
				return true;
			}
			
			return false;
			
		}
		
		public function SwordHealth(otherRef:Object, isPlayer:Boolean, finishTo:World, customLevel:uint=0) {
			
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
			
			bar.clipRect.right = health * 200 / level / 2;
			bar.updateBuffer(true);
			
		}
		
	}
	
}
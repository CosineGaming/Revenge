package	{
	import adobe.utils.CustomActions;
	import net.flashpunk.*;
	import net.flashpunk.graphics.*;
	import net.flashpunk.utils.*;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Player extends Entity	{
		
		[Embed(source = "/../assets/Player.png")] private const PLAYER:Class;
		public var PlayerSM:Spritemap = new Spritemap(PLAYER, 60, 60);
		
		private var vert:Boolean = false;
		
		private var collisions:Array = ["ShopDesk", "Civilian", "WildekGround", "DungeonikeGround"];
		private var oldcollided:Boolean = false;
		
		public static var sword:Number = 1;
		public static var magic:Number = 1;
		public static var speed:Number = 0;
		public static var luckLvl:Number = 0;
		public static var familiar:Number = 0;
		public static function get luck():Number	{
			return luckLvl * 0.075 + 1;
		}
		
		public static function get upgrades():Array	{
			return [sword, magic, speed, luckLvl, familiar];
		}
		public static function set upgrades(vals:Array):void	{
			sword = vals[0];
			magic = vals[1];
			speed = vals[2];
			luckLvl = vals[3];
			familiar = vals[4];
		}
		public static function setUpgrade(upgrade:Number, value:Number):void	{
			
			switch (upgrade)	{
				case 0:
					sword = value;
					break;
				case 1:
					magic = value;
					break;
				case 2:
					speed = value;
					break;
				case 3:
					luckLvl = value;
					break;
				case 4:
					familiar = value;
					break;
			}
			
		}
		public static function increaseUpgrade(upgrade:Number, value:Number):void	{
			
			setUpgrade(upgrade, upgrades[upgrade] + value);
			
		}
		
		public static var money:Number = 500;
		
		public static var items:Array = [0, 0, 0, 0, 0];
		
		public static var statX:Number = 0;
		public static var statY:Number = 0;
		
		private var lastClickX:Number = 0;
		private var lastClickY:Number = 0;
		private var lastClickDeltaX:Number = 0;
		private var lastClickDeltaY:Number = 0;
		private var mouse:Boolean = false;
		
		public function Player(INx:Number=370, INy:Number=550)	{
			
			x = INx;
			y = INy;
			setHitbox(20, 20, -20, -20);
			
			PlayerSM.add("horizontalStand", [0, 1, 2, 3, 4], 10);
			PlayerSM.add("horizontalWalk", [5, 6, 7, 8, 9], 10);
			PlayerSM.add("verticalStand", [10, 11, 12, 13, 14], 10);
			PlayerSM.add("verticalWalk", [15, 16, 17, 18, 19], 10);
			graphic = PlayerSM;
			
			Input.define("Left", Key.LEFT, Key.A);
			Input.define("Right", Key.RIGHT, Key.D);
			Input.define("Up", Key.UP, Key.W);
			Input.define("Down", Key.DOWN, Key.S);
			
			type = "Player";
			
		}
		
		override public function update():void	{
			
			var _x:Number = x;
			var _y:Number = y;
			
			var SPEED:Number = speed / 2 + 5;
			
			if (Input.check(Key.CONTROL) && Input.pressed(Key.DIGIT_4))	{
				money += 1000;
			}
			if (Input.check(Key.TAB))	{
				SPEED = 3;
			}
			if (Input.check(Key.PAGE_UP))	{
				SPEED = 15;
			}
			if (Input.check("Left"))	{
				_x -= SPEED;
				PlayerSM.play("verticalWalk", ((PlayerSM.index + 1) % 5 == 0)); // Restart if done playing
				vert = true;
			}
			if (Input.check("Right"))	{
				_x += SPEED;
				PlayerSM.play("verticalWalk", ((PlayerSM.index + 1) % 5 == 0));
				vert = true;
			}
			if (Input.check("Up"))	{
				_y -= SPEED; // Remember, |4th quadrant|? Ah. Oh. Crap. Time to change all my code.... JK.  :D
				PlayerSM.play("horizontalWalk", ((PlayerSM.index + 1) % 5 == 0));
				vert = false;
			}
			if (Input.check("Down"))	{
				_y += SPEED;
				PlayerSM.play("horizontalWalk", ((PlayerSM.index + 1) % 5 == 0));
				vert = false;
			}
			if (Input.mouseDown)	{
				lastClickX = FP.world.mouseX - 30;
				lastClickY = FP.world.mouseY - 30;
				lastClickDeltaX = lastClickX - _x;
				lastClickDeltaY = lastClickY - _y;
				PlayerSM.play("horizontalWalk", ((PlayerSM.index + 1) % 5 == 0));
				vert = false;
				mouse = true;
			}
			if (mouse)	{
				var distance:Number = Math.sqrt(lastClickDeltaX * lastClickDeltaX + lastClickDeltaY * lastClickDeltaY);
				_x += lastClickDeltaX / distance * SPEED;
				_y += lastClickDeltaY / distance * SPEED;
				if (Math.abs (_x - lastClickX) < SPEED && Math.abs (_y - lastClickY) < SPEED)	{
					mouse = false;
					lastClickX = -1;
				}
			}
			if (Input.released(Key.ANY) || (!mouse && lastClickX == -1))	{
				if (vert) PlayerSM.play("verticalStand", true);
				else PlayerSM.play("horizontalStand", true);
				mouse = false;
			}
			
			if (x != _x || y != _y)	{ // If we are trying to move
				var successes:Array = [];
				var collided:Boolean = false;
				for (var i:Number = 0; i < collisions.length; i++)	{
					if (collide(collisions[i], _x, _y))	{
						collided = true;
						successes.push(collisions[i]);
					}
				}
				if (!collided)	{
					
					x = _x;
					y = _y;
					
					if (!(FP.world.camera.x == 0 && FP.world.camera.y == 0))	{ // Is the world is a scrolling world?
						// Update the camera's position
						FP.world.camera.x = x - 370;
						FP.world.camera.y = y - 267;
					}
					
				}
				else	{
					
					if (vert) PlayerSM.play("verticalStand", true);
					else PlayerSM.play("horizontalStand", true);
					
					for (i = 0; i < successes.length; i++)	{
						
						var hit:String = successes[i];
						
						if (!oldcollided)	{
							
							if (hit == "Civilian")	{
								var outcries:Array = ["Hey!", "Watch it!", "You gotta problem?", "How can I help you?", "Hello.", 
									"Hey, cutie, let's go have sex in the wilds!", "Can you move, please?", "Excuse me.", "The eyes. THE EYES!",
									"Gr...", "Go find a life.", "Go eat your Philly-Cheese-Steak.", "I'm having trouble with my math.\nWould you mind helping me tonight?",
									"Three boobs.", "Don't ask", "...and she was HOT!", "It was THIS LONG!", "Would you mind?", 
									"Dinner on Monday?", "Oh, sorry.", "I'm SO sorry for that.", "Do you need a towel?", "Do you have problems?",
									"DUDE!", "*!&@#^!@&*$^*&!@#^*!&$^!", "@#&$", "!@$%", "@&^!*&@^#!@&#^&!@#!@*#&^*!@#&^!*@#&^!@*#&^!^@#*&!@^#*&!@^#*&!@#^*!&@#^*!&@#^",
									"You look sad. You need something?", "TAKE THIS!", "You want this?", "Money for the rich? :)", "That's a mighty scar you got there!\nDo tell...",
									"I once was an adventurer like you,\n but then I took an arrow, to the knee.", "Adventurers, Pff...",
									"Go find something better to do with your life.", "Also try Minecraft!", ".\n..\n...\n....\n.....\n......",
									"* No Comment *", " ", " ", " ", " ", " ", " ", " ", "How's it going, Dildo Faggins?\nYou OK, Third Leg-less?\nNice to see you Hairyporn.",
									"Don't go there.", "RAPE!", "You should learn C++.", "Made in Flash with Flashpunk!", "Thanks to Incompetech.com for music!", 
									// Usefuls (5):
									"I've heard that if you travel North at Wildek,\nyou'll find a Wizard who'll tell you anything.",
									"I've heard if you travel South at Wildek,\nyou'll find an evil goblin who can't be defeated.",
									"I've heard if you travel East at Wildek,\n you'll find a jackpot of Gold.", 
									"I've heard if you travel West at Wildek,\nyou'll find void. Nothing's there.\nSome people say it's the end of the world.",
									"Poppy talk. It's all poppy talk.\nDon't believe anything they tell you."];
								var outcryIndex:Number = h.Random(int(outcries.length * 1.15));
								if (outcryIndex > outcries.length)	{
									outcryIndex = outcries.length - h.Random(1, 6);
								}
								var outcry:String = outcries[outcryIndex];
								var addGold:Number = h.Random(3);
								money += addGold;
								FP.world.add(new text(outcry + "\n" + String(addGold) + " GP Added", x, y, 1));
							}
							
							if (hit == "ShopDesk")	{
								FP.world.add(new ShopGUI);
								FP.world.remove(ShopDesk.warnButton);
							}
						
						}
						
						if (hit == "WildekGround" || hit == "DungeonikeGround")	{
							
							var column:int = (x + 20) / 100; // To get type of collision on ground
							var row:int = (y + 20) / 100;
							var tile:int;
							if (hit == "WildekGround")	tile = WildekGround.tilemap.getTile(column, row);
							else	tile = DungeonikeGround.tilemap.getTile(column, row);
							if (tile == 0)	{
								column = (x + 41) / 100;
								row = (y + 41) / 100;
								if (hit == "WildekGround")	tile = WildekGround.tilemap.getTile(column, row);
								else	tile = DungeonikeGround.tilemap.getTile(column, row);
							}
							
							if (tile < 6)	{
								x = _x; // Still move
								y = _y;
								FP.world.camera.x = x - 370;
								FP.world.camera.y = y - 267;
							}
							
							if (tile == 1)	{
								if (hit == "WildekGround")	FP.world = new ShopWorld(370, 0);
								else	FP.world = new ShopWorld(370, 535);
							}
							else if (tile == 2)	{
								if (h.Random(4 * luck) == 1)	{
									FP.world.add(new text("Whatcha doin' on my orb grass?", x, y + 25, 1, null, battle));
								}
								var upgradeVal:Number = h.Random(4 * luck);
								var upgradeIndex:Number = h.Random(2);
								increaseUpgrade(upgradeIndex, upgradeVal);
								FP.world.add(new text(["Weapon", "Magic"][upgradeIndex] + " upgraded by " + String(upgradeVal) + " to " + String(upgrades[upgradeIndex]), x, y, 1));
							}
							else if (tile == 3)	{
								FP.world.add(new text("Grrr...", x, y, 1, null, battle));
							}
							else if (tile == 4)	{
								var moneyVal:Number = h.Random(150 * Player.luck);
								money += moneyVal;
								FP.world.add(new text(String(moneyVal) + " GP added\n" + String(money) + " GP Total", x, y, 1));
							}
							else if (tile == 5)	{
								var gotoWorld:World = FP.world;
								var downfallWorld:World = new DecisionWorld("By what means would you like to destroy the peoples before you?",
									["My Blade (LVL " + String(sword) + ") shall pierce them.", "My Magic skills (LVL " + String(magic) + ") shall crush them."],
									[function():void	{ FP.world = new BattleWorld(gotoWorld, 0, 5) }, function():void	{ FP.world = new BattleWorld(gotoWorld, 1, 5) } ]
								);
								FP.world = new DecisionWorld("What are your intentions?", 
									["I wish to trade and make peace.", "I wish to see your downfall"], 
									[function():void {	FP.world = new VillageWorld(gotoWorld);	}, function():void { FP.world = downfallWorld } ]);
							}
							
							if (hit == "WildekGround")	{if (tile < 6)	WildekGround.tilemap.setTile(column, row, 0);}
							else	DungeonikeGround.tilemap.setTile(column, row, 0);
							
						}
						
					}
					
				}
				
				oldcollided = collided; // Store collided in oldcollided so that we don't collide more than we need to
				
				if (FP.world.name == "Shop")	{ // Enter The WILDS!
					if (y < 0)	{
						FP.world = new Wildek;
					}
					if (y > 535)	{
						FP.world = new Dungeonike;
					}
				}
				
			}
			
			if (FP.world.name == "Dungeonike" && h.Random(180) == 0)	FP.pan = h.Random(-1, 2);
			else if (FP.pan != 0)	FP.pan -= FP.pan / 30;
			
			statX = x;
			statY = y;
			
		}
		
		private function battle():void	{
			
			var currWildek:World = FP.world;
			
			FP.world = new DecisionWorld("By what means would you like to crush the dreadful monster before you?",
				["My Blade (LVL " + String(sword) + ") shall pierce it.", "My Magic skills (LVL " + String(magic) + ") shall destroy it."],
				[function():void	{ FP.world = new BattleWorld(currWildek, 0) }, function():void	{ FP.world = new BattleWorld(currWildek, 1) } ]
			);
			
		}
		
	}
	
}
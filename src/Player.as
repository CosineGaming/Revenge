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
		
		public static var upgrades:Array = [1, 1, 0, 0, 0];
		
		public static function get sword():uint { return upgrades[0]; }
		public static function set sword(value:uint):void { upgrades[0] = value; }
		
		public static function get magic():uint { return upgrades[1]; }
		public static function set magic(value:uint):void { upgrades[1] = value; }
		
		public static function get speed():uint { return upgrades[2]; }
		public static function set speed(value:uint):void { upgrades[2] = value; }
		
		public static function get luckLvl():uint { return upgrades[3]; }
		public static function set luckLvl(value:uint):void { upgrades[3] = value; }
		
		public static function get familiar():uint { return upgrades[4]; }
		public static function set familiar(value:uint):void { upgrades[4] = value; }
		
		public static function get luck():Number	{
			return luckLvl * 0.075 + 1;
		}
		
		public static var money:Number = 500;
		
		public static var items:Array = [0, 0];
		
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
			
			var movementSpeed:Number = (speed / 2 + 5) * 40 * FP.elapsed; // Dynamic Framerate
			
			if (Input.check(Key.CONTROL) && Input.pressed(Key.DIGIT_4))	{
				money += 1000;
			}
			if (Input.check(Key.TAB))	{
				movementSpeed = 200 * FP.elapsed;
			}
			if (Input.check(Key.PAGE_UP))	{
				movementSpeed = 1000 * FP.elapsed;
			}
			if (Input.check("Left"))	{
				_x -= movementSpeed;
				PlayerSM.play("verticalWalk", ((PlayerSM.index + 1) % 5 == 0)); // Restart if done playing
				vert = true;
			}
			if (Input.check("Right"))	{
				_x += movementSpeed;
				PlayerSM.play("verticalWalk", ((PlayerSM.index + 1) % 5 == 0));
				vert = true;
			}
			if (Input.check("Up"))	{
				_y -= movementSpeed; // Remember, |4th quadrant|? Ah. Oh. Crap. Time to change all my code.... JK.  :D
				PlayerSM.play("horizontalWalk", ((PlayerSM.index + 1) % 5 == 0));
				vert = false;
			}
			if (Input.check("Down"))	{
				_y += movementSpeed;
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
				_x += lastClickDeltaX / distance * movementSpeed;
				_y += lastClickDeltaY / distance * movementSpeed;
				if (Math.abs (_x - lastClickX) < movementSpeed && Math.abs (_y - lastClickY) < movementSpeed)	{
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
					
					mouse = false;
					
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
									"* No Comment *", " ", "Don't go there.", "RAPE!", "You should learn C++.", "Made in Flash with Flashpunk!",
									"Thanks to Incompetech.com for music!", "By Cosine Gaming", "Revenge", "Revenge by Cosine Gaming", "Visit cosinegaming.com", "cosinegaming.com",
									"You should go to cosinegaming.com", "Cosine Gaming makes free indy games.", "Go to cosinegaming.com for more free indy games.",
									"By Cosine Gaming", "Revenge", "Revenge by Cosine Gaming", "Visit cosinegaming.com", "cosinegaming.com",
									"You should go to cosinegaming.com", "Cosine Gaming makes free indy games.", "Go to cosinegaming.com for more free indy games."];
								var outcry:String = outcries[h.Random(outcries.length)]
								var addGold:Number = h.Random(3);
								money += addGold;
								FP.world.add(new text(outcry + "\n" + String(addGold) + " GP Added", x, y, 1));
							}
							
							if (hit == "ShopDesk")	{
								FP.world = new ShopGUI(FP.world);
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
									FP.world.add(new text("Whatcha doin' on my orb grass?", x, y + 25, 1, null, hit == "WildekGround" ? function():void { battle(0, FP.world) } : function():void { battle(10, FP.world) } ));
								}
								var upgradeVal:Number = h.Random(2 * luck + (6 * uint(hit == "DungeonikeGround")));
								var upgradeIndex:Number = h.Random(2);
								upgrades[upgradeIndex] += upgradeVal;
								FP.world.add(new text(["Weapon", "Magic"][upgradeIndex] + " upgraded by " + String(upgradeVal) + " to " + String(upgrades[upgradeIndex]), x, y, 1));
							}
							else if (tile == 3)	{
								FP.world.add(new text("Grrr...", x, y, 1, null, hit == "WildekGround" ? function():void { battle(0, FP.world) } : function():void { battle(10, FP.world) }));
							}
							else if (tile == 4)	{
								var moneyVal:Number = h.Random(150 * Player.luck);
								money += moneyVal;
								FP.world.add(new text(String(moneyVal) + " GP added\n" + String(money) + " GP Total", x, y, 1));
							}
							else if (tile == 5)	{
								var gotoWorld:World = FP.world;
								FP.world = new DecisionWorld("What are your intentions?", 
									["I wish to trade and make peace.", "I wish to see your downfall"], 
									[function():void {	FP.world = new ShopGUI(gotoWorld, true);	}, function():void { battle(10, gotoWorld) } ]);
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
		
		private function battle(stakes:uint, back:World):void	{
			
			var magicLevel:uint = h.Random(Player.luck * (Player.magic + stakes) * 0.5, Player.luck * (Player.magic + stakes) * 1.5);
			var swordLevel:uint = h.Random(Player.luck * (Player.sword + stakes) * 0.5, Player.luck * (Player.sword + stakes) * 1.5);
			
			FP.world = new DecisionWorld("By what means would you like to crush the dreadful enemy before you?",
				["My level " + String(sword) + " blade shall pierce its level " + String(swordLevel) + " blade.",
				"My level " + String(magic) + " magic shall destroy its level " + String(magicLevel) + " magic."],
				[function():void	{ FP.world = new BattleWorld(back, 0, swordLevel) },
				function():void	{ FP.world = new BattleWorld(back, 1, magicLevel) } ]
			);
			
		}
		
	}
	
}
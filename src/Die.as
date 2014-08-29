package	{
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	public class Die extends Entity	{
		
		[Embed(source = "/../assets/Dice.png")] private const DICE:Class;
		[Embed(source = "/../assets/DiceSmall.png")] private const DICESMALL:Class;
		public var DiceSM:Spritemap;
		
		private var totalTime:Number = 0;
		private var toGoTo:Number = h.Random(1, 3);
		
		public static var PlayerLevel:Number;
		public static var EnemyLevel:Number;
		public static var LevelType:Number;
		public static var PlayerTotal:Number = 0;
		public static var EnemyTotal:Number = 0;
		public static var StakesMultiplier:Number = 1;
		
		private var small:Boolean;
		private var dispText:Boolean;
		private var enemy:Boolean;
		
		private var gotoWorld:World;
		
		private var dieValue:Number = -1;
		
		public function Die(storeWorld:World, _small:Boolean = false, _x:Number = 325, _y:Number = 225, isEnemy:Boolean = false, level:Boolean = false, stakesMultiplier:Number = 1)	{
			
			x = _x;
			y = _y;
			
			gotoWorld = storeWorld;
			
			if (_small)	DiceSM = new Spritemap(DICESMALL, 75, 75);
			else	DiceSM = new Spritemap(DICE, 150, 150);
			
			small = _small;
			dispText = !small;
			enemy = isEnemy;
			PlayerLevel = Player.upgrades[level];
			LevelType = uint(level);
			StakesMultiplier = stakesMultiplier;
			
			if (dispText)	toGoTo = h.Random(3, 5);
			
			DiceSM.add("animate", [1, 0, 4, 5, 2, 3], h.Random(5, 30));
			graphic = DiceSM;
			DiceSM.play("animate");
			
		}
		
		override public function update():void	{
			
			totalTime += FP.elapsed;
			
			if (totalTime > toGoTo && dieValue == -1)	{
				
				if (!enemy)	dieValue = h.Random(6 * Player.luck);
				if (enemy)	dieValue = h.Random(6 / Player.luck);
				if (dieValue > 5)	dieValue = 5;
				DiceSM.setFrame(dieValue, 0);
				
				var level:Number;
				var total:Number;
				if (enemy)	{
					level = h.Random(1, (PlayerLevel + Player.familiar) * 1.3);
					EnemyLevel = level;
					var type:String = [" (Sword)", " (Magic)"][h.Random(2)];
					total = (dieValue + 1) * level;
					EnemyTotal += total;
					FP.world.add(new text(" X " + String(level) + type + " = " + String(total) + " (Enemy)", 575, 425));
				}
				else	{
					if (!small)	level = PlayerLevel;
					else	level = h.Random(1, Player.familiar);
					total = (dieValue + 1) * level;
					var _x:Number;
					if (small)	_x = 25;
					else	_x = 350;
					PlayerTotal += total;
					FP.world.add(new text(" X " + String(level) + " = " + String(total), _x, 425));
				}
				
				if (dispText)	{
					
					var moneyVal:Number;
					
					FP.world.add(new text("Player's Score: " + String(PlayerTotal) + "\nEnemy's Score: " + String(EnemyTotal), 280, 25, 0, null, null, 20));
					
					if (PlayerTotal >= EnemyTotal)	{
						var upgradeVal:Number = h.Random(3 * Player.luck);
						moneyVal = h.Random(500 * (EnemyLevel / PlayerLevel) * Player.luck * StakesMultiplier);
						Player.increaseUpgrade(LevelType, upgradeVal);
						Player.money += moneyVal;
						FP.world.add(new text("   You win! " + ["Weapon", "Magic"][LevelType] + " upgraded by " + String(upgradeVal) + " to " + Player.upgrades[LevelType] + "!\nYou won " + String(moneyVal) + " Gold! You now have " + Player.money + " Gold!", 150, 475, 7, gotoWorld, null, 24));
					}
					else	{
						moneyVal = h.Random(500 / Player.luck * StakesMultiplier);
						if (moneyVal > Player.money)	moneyVal = Player.money;
						Player.money -= moneyVal;
						FP.world.add(new text("You lose... " + String(moneyVal) + " Gold lost. You now have " + String(Player.money) + " Gold.", 125, 475, 7, gotoWorld, null, 24));
					}
					
					EnemyTotal = 0;
					PlayerTotal = 0;
					
				}
				
			}
			
		}
		
	}
	
}
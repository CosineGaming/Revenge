package {
	import adobe.utils.ProductManager;
	import flash.events.StatusEvent;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class BattleWorld extends World	{
		
		private var currentWildek:World;
		
		[Embed(source = "/../assets/BattleMagic.png")] private const magicBG:Class;
		[Embed(source = "/../assets/BattleSword.png")] private const swordBG:Class;
		
		public function BattleWorld(storeWorld:World, magic:Boolean, enemyLevel:Number = 0)	{
			
			currentWildek = storeWorld;
			
			if (magic)
			{
				
				var bg:Entity = new Entity(0, 0, new Image(magicBG));
				bg.layer = 100;
				add(bg);
				var player:Object = new Object;
				var enemy:Object = new Object;
				player.panel = new MagicPanel(true, enemy);
				enemy.panel = new MagicPanel(false, player, enemyLevel);
				add(player.panel);
				add(enemy.panel);
				add(new MagicSpells(player.panel));
				add(new MagicBar(true, true, player.panel, storeWorld));
				add(new MagicBar(true, false, enemy.panel, storeWorld));
				add(new MagicBar(false, true, player.panel, storeWorld));
				add(new MagicBar(false, false, enemy.panel, storeWorld));
				
			}
			else 
			{
				
				var bg:Entity = new Entity(0, 0, new Image(swordBG));
				bg.layer = 100;
				add(bg);
				var player:Object = new Object;
				var enemy:Object = new Object;
				player.sword = new SwordHealth(enemy, true, storeWorld);
				enemy.sword = new SwordHealth(player, false, storeWorld, enemyLevel);
				add(player.sword);
				add(enemy.sword);
				const size:uint = 150;
				const padding:uint = 10;
				const originX:uint = 20;
				const originY:uint = 265;
				for (var gridX:uint = 0; gridX < 2; gridX++)
					for (var gridY:uint = 0; gridY < 2; gridY++)
						add(new Button(gridX * (size + padding) + originX, gridY * (size + padding) + originY,
							size, size, turn(player, gridX, gridY), null, false));
				add(new Button(400, 295, 240, 240, function():void { player.sword.endTurn(); trace("ENDTURN"); }, null, false));
				
			}
			
			/*if (Player.familiar > 0)	add(new Die(storeWorld, true, 75, 265));
			add(new Die(storeWorld, false, 325, 225, false, magic, stakes));
			add(new Die(storeWorld, true, 675, 265, true, magic));*/
			
		}
		
		private function turn(player:Object, x:uint, y:uint):Function	{
			return function():void	{
				player.sword.turn(x, y);
				trace("TURN: ", x, ", ", y);
			};
		}
		
		override public function begin():void	{
			
			h.playRand("battle", 2);
			
		}
		
	}
	
}
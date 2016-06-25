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
				add(new Button(originX             , originY             , size, size  , turn(player, 0), null, false));
				add(new Button(originX             , originY+size+padding, size, size  , turn(player, 1), null, false));
				add(new Button(originX+size+padding, originY             , size, size*2, turn(player, 2), null, false));
				add(new Button(400, 295, 240, 240, function():void { player.sword.endTurn(); trace("ENDTURN"); }, null, false));
				
			}
			
			/*if (Player.familiar > 0)	add(new Die(storeWorld, true, 75, 265));
			add(new Die(storeWorld, false, 325, 225, false, magic, stakes));
			add(new Die(storeWorld, true, 675, 265, true, magic));*/
			
		}
		
		private function turn(player:Object, move:uint):Function	{
			return function():void	{
				player.sword.turn(move);
				trace("TURN: ", move);
			};
		}
		
		override public function begin():void	{
			
			h.playRand("battle", 2);
			
		}
		
	}
	
}
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
		
		public function BattleWorld(storeWorld:World, magic:Boolean, enemyLevel:Number = 0)	{
			
			currentWildek = storeWorld;
			
			if (magic)
			{
				var bg:Entity = new Entity(0, 0, new Image(magicBG), null);
				bg.layer = 100;
				add(bg);
				var player:Object = new Object;
				var enemy:Object = new Object;
				player.panel = new MagicPanel(true, enemy);
				enemy.panel = new MagicPanel(false, player, enemyLevel);
				add(player.panel);
				add(enemy.panel);
				add(new MagicSpells(player.panel));
				add(new StatMarker(true, true, player.panel, storeWorld));
				add(new StatMarker(true, false, enemy.panel, storeWorld));
				add(new StatMarker(false, true, player.panel, storeWorld));
				add(new StatMarker(false, false, enemy.panel, storeWorld));
			}
			
			/*if (Player.familiar > 0)	add(new Die(storeWorld, true, 75, 265));
			add(new Die(storeWorld, false, 325, 225, false, magic, stakes));
			add(new Die(storeWorld, true, 675, 265, true, magic));*/
			
		}
		
		override public function begin():void	{
			
			h.playRand("battle", 2);
			
		}
		
	}
	
}
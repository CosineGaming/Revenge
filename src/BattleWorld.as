package {
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
		
		[Embed(source = "/../assets/WolfIcon.png")] private const WOLF:Class;
		[Embed(source = "/../assets/Unknown.png")] private const UK:Class;
		[Embed(source = "/../assets/PlayerIcon.png")] private const PI:Class;
		[Embed(source = "/../assets/Eye.png")] private const EYE:Class;
		
		public function BattleWorld(storeWorld:World, level:Number, stakes:Number = 1)	{
			
			currentWildek = storeWorld;
			
			if (Player.familiar > 0)	add(new Die(storeWorld, true, 75, 265));
			add(new Die(storeWorld, false, 325, 225, false, level));
			add(new Die(storeWorld, true, 675, 265, true, level * stakes));
			
			if (Player.familiar > 0)	add(new Entity(75, 100, new Image(WOLF)));
			else	add(new Entity(75, 100, new Image(UK)));
			add(new Entity(325, 100, new Image(PI)));
			add(new Entity(675, 100, new Image(EYE)));
			
		}
		
		public function goBack():void	{
			FP.world = currentWildek;
		}
		
		override public function begin():void	{
			
			h.playRand("battle", 2);
			
		}
		
	}
	
}
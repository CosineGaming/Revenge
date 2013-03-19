package 
{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author Cosine Gaming
	 */
	public class VillageWorld extends World	{
		
		private var gotoWorld:World;
		
		public function VillageWorld(currWildek:World)	{
			
			gotoWorld = currWildek;
			
			add(new ShopGUI(true, die));
			add(new MoneyCounter);
			
		}
		
		public function die():void	{
			
			FP.world = gotoWorld;
			
		}
		
	}
	
}
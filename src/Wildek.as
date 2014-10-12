package	{
	import net.flashpunk.FP;
	import net.flashpunk.World;
	import net.flashpunk.Sfx;
	import net.flashpunk.tweens.sound.SfxFader;
	
	/**
	 * ...
	 * @author Cosine Gaming
	 */
	
	public class Wildek extends World	{
		
		private static var instructions:String = "\
			   	  Welcome to Wildek.\n\
This is where you will find fights for quests and experience.\n\
		  	 You may also find \"Orb Grass.\"\n\
	   These will boost your magic and weapon abilities.\n\
    Look for gold grass, they're an easy way to get gold.\n\
In the outskirts of Wildek you might just find another village.\n\
    Here you can trade or attempt to take on the village.\n\
Begin by walking around and looking for anything interesting.\n\
                      Good Luck!";
		
		public function Wildek()	{
			
			name = "Wildek";
			
			add(new WildekGround);
			add(new text(instructions, 3800, 2800, 7));
			add(new HomeMarker);
			
			for (var i:Number = 0; i < h.Random(20 * Player.luck); i++)	{
				add(new Civilian(0, 8000, 6000));
			}
			
			add(new MoneyCounter);
			add(new Player(4030, 2950));
			
			camera.x = 3630;
			camera.y = 2674;
			
			Wildek.instructions = "\n\n\n\n							       Good Luck!";
			
		}
		
		override public function begin():void	{
			
			h.playRand("wildek", 2);
			
		}
		
	}
	
}
package	{
	import net.flashpunk.*;
	import net.flashpunk.graphics.Spritemap;
	import net.flashpunk.utils.Input;
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class Civilian extends Entity	{
		
		[Embed(source = "/../assets/Civilian.png")] private const CIVILIAN:Class;
		private var CivilianSM:Spritemap = new Spritemap(CIVILIAN, 60, 60);
		
		private var dirX:Number = h.Random(-3, 3);
		private var dirY:Number = h.Random(-3, 3);
		private var wlklen:Number = h.Random(90);
		private var wlkpause:Number = h.Random(180);
		private var wlkcount:int = 0;
		private var checkwalk:Number = Math.random();
		private var walking:Boolean;
		
		public function Civilian(xyMin:Number = 60, xMax:Number = 740, yMax:Number = 540)	{
			
			for (var i:Number = 0; i < 6; i++)	{
				CivilianSM.add(String(i), [i], 0, true);
			}
			graphic = CivilianSM;
			
			setHitbox(20, 20, -20, -20);
			
			x = h.Random(xyMin, xMax);
			y = h.Random(xyMin, yMax);
			
			var grtype:int = h.Random(5);
			CivilianSM.play(String(grtype));
			if (checkwalk < 0.5) walking = false;
			else walking = true;
			
			type = "Civilian";
			
		}
		
		override public function update():void	{
			
			if (walking)	{
				x += dirX;
				y += dirY;
			}
			if (wlkcount == wlkpause && walking == false)	{
				walking = true;
				wlkcount = 0;
			}
			if (wlkcount == wlklen && walking)	{
				walking = false;
				dirX = h.Random(-3, 3);
				dirY = h.Random( -3, 3);
				wlklen = h.Random(30);
				wlkpause = h.Random(60);
				if (dirX == 0)	{
					if (CivilianSM.frame % 2 != 0)	{ // Vertical body: walking horizontally (Not the right way)
						CivilianSM.play(String(CivilianSM.frame - 1));
					}
				}
				else if (dirY == 0)	{
					if (CivilianSM.frame % 2 == 0)	{
						CivilianSM.play(String(CivilianSM.frame + 1));
					}
				}
				wlkcount = 0;
			}
			wlkcount++;
			
		}
		
	}
	
}
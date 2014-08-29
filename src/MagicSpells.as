package 
{
	import net.flashpunk.Entity;
	import net.flashpunk.graphics.Graphiclist;
	import net.flashpunk.graphics.Text;
	import net.flashpunk.utils.Input;
	import net.flashpunk.utils.Key;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MagicSpells extends Entity
	{
		
		private var graphics:Graphiclist;
		
		private var panel:MagicPanel;
		
		private var numSpells:uint;
		
		public function MagicSpells(player:MagicPanel)
		{
			
			x = 50
			y = 500;
			
			panel = player;
			
			layer = 5;
			
			numSpells = Math.sqrt(Player.magic);
			
			graphics = new Graphiclist;
			
			var settings:Object = new Object;
			settings.size = 45;
			settings.color = 0xFF0000;
			for (var i:uint = 0; i < numSpells; ++i)
			{
				var display:String = String(i + 1);
				graphics.add(new Text(display, 5 + i * 50, 5, settings));
			}
			settings.color = 0x00FF00;
			for (var i:uint = 0; i < numSpells * 2; ++i)
			{
				var display:String = String(i + 1);
				graphics.add(new Text(display, 5 + i * 50, 55, settings));
			}
			
			graphic = graphics;
			
		}
		
		override public function update():void
		{
			if (Input.mousePressed)
			{
				var spell:int = int((Input.mouseX - 50) / 50);
				var defense:int = int((Input.mouseY - 500) / 50);
				if (spell >= 0 && ((spell < numSpells && defense == 0) || (spell < numSpells * 2 && defense == 1)))
				{
					// Right area
					spell += 1;
					panel.list.push(spell + defense * 100); // Attack: 2, Defense: 102
				}
			}
			if (Input.pressed(Key.DIGIT_1))	panel.list.push(1 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_2))	panel.list.push(2 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_3))	panel.list.push(3 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_4))	panel.list.push(4 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_5))	panel.list.push(5 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_6))	panel.list.push(6 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_7))	panel.list.push(7 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_8))	panel.list.push(8 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_9))	panel.list.push(9 + uint(Input.check(Key.SHIFT)) * 100);
			if (Input.pressed(Key.DIGIT_0))	panel.list.push(10 + uint(Input.check(Key.SHIFT)) * 100);
		}
	}
	
}
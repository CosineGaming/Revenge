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
			for (var i:uint = 0; i < numSpells + 1; ++i)
			{
				var display:String = String(i + 1);
				graphics.add(new Text(display, 5 + i * 50, 55, settings));
			}
			
			graphic = graphics;
			
		}
		
		public static function cast(spell:uint, defense:Boolean, maxSpell:uint, onPanel:MagicPanel):void
		{
			if (spell > 0 && ((spell <= maxSpell && defense == 0) || (spell <= maxSpell + 1 && defense == 1)))
			{
				if (!defense)
				{
					if (onPanel.mana >= spell)
					{
						onPanel.mana -= spell;
					}
					else
					{
						return;
					}
				}
				onPanel.list.push(spell + uint(defense) * 100); // Attack: 2, Defense: 102
			}
		}
		
		override public function update():void
		{
			if (Input.mousePressed)
			{
				var spell:int = int((Input.mouseX - 50) / 50) + 1;
				var defense:int = int((Input.mouseY - 500) / 50);
				cast(spell, defense, numSpells, panel);
			}
			if (Input.pressed(Key.DIGIT_1))	cast(1, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_2))	cast(2, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_3))	cast(3, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_4))	cast(4, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_5))	cast(5, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_6))	cast(6, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_7))	cast(7, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_8))	cast(8, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_9))	cast(9, Input.check(Key.SHIFT), numSpells, panel);
			if (Input.pressed(Key.DIGIT_0))	cast(10, Input.check(Key.SHIFT), numSpells, panel);
		}
	}
	
}
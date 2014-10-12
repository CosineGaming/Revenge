package 
{
	import flash.geom.Rectangle;
	import net.flashpunk.Entity;
	import net.flashpunk.FP;
	import net.flashpunk.graphics.Image;
	import net.flashpunk.World;
	
	/**
	 * ...
	 * @author ...
	 */
	public class MagicBar extends Entity
	{
		
		[Embed(source = "../assets/HealthBar.png")] private var healthBar:Class;
		[Embed(source = "../assets/ManaBar.png")] private var manaBar:Class;
		
		private var displayBar:Image;
		
		private var player:Boolean;
		
		private var panel:MagicPanel;
		
		private var finish:World;
		
		private var mana:Boolean;
		
		public function MagicBar(isMana:Boolean, isPlayer:Boolean, trackPanel:MagicPanel, finishWorld:World):void
		{
			x = 10 + 580 * uint(isPlayer);
			y = 1 + 21 * uint(isMana);
			
			mana = isMana;
			
			player = isPlayer;
			panel = trackPanel;
			
			finish = finishWorld;
			
			displayBar = isMana ? new Image(manaBar) : new Image(healthBar);
			graphic = displayBar;
		}
		
		override public function update():void
		{
			if (!mana)
			{
				if (panel.health <= 0)
				{
					var target:uint = Math.sqrt(panel.other.level) * 225;
					var gold:Number = h.Random(target * 0.5, target * 1.5);
					var item:Number = -1;
					if (gold > Player.money)
					{
						gold = Player.money;
						if (Player.items[0])
						{
							item = 0;
						}
						else if (Player.items[1])
						{
							item = 1;
						}
					}
					var words:String;
					if (player)
					{
						Player.money -= gold;
						words = "The enemy spits at your dazed body\nand walks away with " + (Player.money == 0 ? "all " : "") + String(gold) + " of your Gold.";
						if (item != -1)
						{
							words += "\nThe enemy also takes all " + String(Player.items[item]) + " of your " + ["wood", "metal"][item] + ".";
						}
					}
					else 
					{
						Player.money += gold;
						words = "You search the barely concious enemy\nand take " + String(gold) + " of the their Gold.";
					}
					if (Player.money != 0)
					{
						words += "\nYou now have " + String(Player.money) + " Gold.";
					}
					FP.world.add(new text(words, 100, 100, 4, finish));
					FP.world.remove(this);
					FP.world.remove(panel);
				}
			}
			displayBar.clipRect.width = (mana ? panel.mana : panel.health) / panel.level / 2 * 200;
			displayBar.updateBuffer(true);
		}
	}
	
}
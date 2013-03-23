package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import mochi.as3.*;
	import net.flashpunk.FP;
	import net.flashpunk.Sfx;
	import net.flashpunk.Tween;
	import net.flashpunk.tweens.sound.SfxFader;
	import splash.Splash;
	import flash.system.Security;
	
	
	/**
	 * ...
	 * @author Christopher Phonis-Phine
	 */
	
	public class h	{
		
		/**
		 * Random number
		 * @param	minimum
		 * @param	maximum
		 * @return	random number from min to max
		 */
		public static function Random(arg1:Number, arg2:Number = 0):int	{
			
			var min:Number;
			var max:Number;
			if (arg2 == 0)	{
				min = 0;
				max = arg1;
			}
			else	{
				min = arg1;
				max = arg2;
			}
			return Math.random() * (max - min) + min;
			
		}
		
		public static function nothing():void	{
			// Do nothing
		}
		
		public static function wait(time:Number):void	{
			for (var i:int = 0; i < time * 1000; i++)	{
				nothing(); // Just give the computer something to do
			}
		}
		
		public static function print(INtext:String):void	{
			FP.world.add(new text(INtext, Player.statX, Player.statY, 1));
		}
		
		public static function createAd():void	{
			
			var Container:MovieClip = new MovieClip();
			
			FP.stage.addChild(Container);
			
			MochiServices.connect("613c47c463dbc40f", Container);
			
			MochiAd.showPreGameAd( { clip:Container, id:"613c47c463dbc40f", res:"800x595",
				background:0xCCCCCC, color:0xFF0000, outline:0x00FF00, no_bg:true,
				ad_started:function():void {},
				ad_finished:function():void { var s:Splash = new Splash; FP.world.add(s); s.start(new LoadWorld); }
				}
			);
			
		}
		
		public static var currSound:Sfx;
		
		public static function playRand(type:String, numPoss:Number):void	{
			
			play(type + "/" + String(Random(1, numPoss + 1)) + ".mp3");
			
		}
		
		public static function play(soundPath:String):void	{
			
			if (currSound != null)	currSound.stop();
			
			var sound:Sfx = Loaded.loaded[soundPath];
			
			if (sound == null)	{
				LoadWorld.tips = ["Loading unseen file " + soundPath + "."];
				LoadWorld.toLoad = [soundPath];
				FP.world = new LoadWorld(FP.world);
				sound = Loaded.loaded[soundPath];
			}
			
			if (sound != null)	{
				sound.loop();
				currSound = sound;
			}
			else	{
				FP.world.add(new text("Oops... there seems to be a problem with the sound. Sorry!", 10, 10, 3));
			}
			
		}
		
	}
	
}
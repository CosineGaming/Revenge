package 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.setTimeout;
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
		
		public static function print(INtext:String):void	{
			FP.world.add(new text(INtext, Player.statX, Player.statY, 1));
		}
		
		public static var currSound:Sfx;
		
		public static function playRand(type:String, numPoss:Number, loop:Boolean=false, display:Boolean=false):void	{
			
			play(type + "/" + String(Random(1, numPoss + 1)) + ".mp3", loop, display);
			
		}
		
		public static function play(soundPath:String, loop:Boolean=false, display:Boolean=false):void	{
			
			var sound:Sfx = Loaded.loaded[soundPath];
			
			if (sound == null)	{
				LoadWorld.toLoad = [soundPath];
				var load:LoadWorld;
				if (display)	{
					load = new LoadWorld(FP.world);
					FP.world = load;
				}
				else	{
					var goto:Function = function ():void	{ play (soundPath, loop, display); }
					load = new LoadWorld(null, goto);
				}
				load.Load();
			}
			else	{
				var fader:SfxFader;
				if (currSound)	{
					fader = new SfxFader(currSound);
					fader.crossFade(sound, loop, 1);
				}
				else 	{
					sound.volume = 0;
					if (loop)	sound.loop();
					else	sound.play();
					fader = new SfxFader(sound);
					fader.fadeTo(1, 1);
					currSound = sound;
				}
			}
			
		}
		
	}
	
}
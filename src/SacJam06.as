package
{
	import flash.display.Sprite;
	
	import org.flixel.FlxGame;
	
	[SWF(backgroundColor="0x330066", width="900", height="600")]
	
	[Frame(FactoryClass="Preloader")]
	
	public class SacJam06 extends FlxGame
	{
		public function SacJam06()
		{
			super( 900, 600, PlayState );
		}
	}
}
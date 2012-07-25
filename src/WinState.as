package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	
	public class WinState extends FlxState
	{
		[Embed(source="../assets/playerOne.png")] public var rawPlayerOne:Class;
		[Embed(source="../assets/playerTwo.png")] public var rawPlayerTwo:Class;
		
		public var playerOne:FlxSprite;
		public var playerTwo:FlxSprite;

		public function WinState()
		{	
			
		}
		
		override public function create():void
		{
			
			//PLAYERS
			playerOne = new FlxSprite( 300, 300, rawPlayerOne );
			playerTwo = new FlxSprite( 300, 300, rawPlayerTwo );
			
			
			if( PlayState.playerOneScore > PlayState.playerTwoScore )
			{
				add( playerOne );
			}
			else
			{
				add( playerTwo );
			}
		}
	}
}
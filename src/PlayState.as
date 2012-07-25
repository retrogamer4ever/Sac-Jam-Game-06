package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;

	
	public class PlayState extends FlxState
	{
		[Embed(source="../assets/playerOne.png")] public var rawPlayerOne:Class;
		[Embed(source="../assets/playerTwo.png")] public var rawPlayerTwo:Class;
		
		
		[Embed(source="../assets/platform.png")] public var rawPlatform:Class;
		[Embed(source="../assets/bottomPlatform.png")] public var rawBottomPlatform:Class;
		
		
		[Embed(source="../assets/button.png")] public var rawButton:Class;
		
		[Embed(source="../assets/doorway.png")] public var rawDoor:Class;
		
		
		public static var playerOneScore:int = 0;
		public static var playerTwoScore:int = 0;
		
		public var buttonOnePressed:Boolean = false;
		public var buttonTwoPressed:Boolean = false;
		public var buttonsPressed:Boolean   =  false;
		
		
		//DOOR
		public var door:FlxSprite;
		
		
		//BUTTONS
		public var topButton:FlxSprite;
		public var bottomButton:FlxSprite;
		
		//PLAYERS
		public var playerOne:FlxSprite;
		public var playerTwo:FlxSprite;
		
		
		//PLATFORMS
		
		public var veryTopPlatform:FlxSprite;
		public var topPlatform:FlxSprite;
		public var bottomPlatform:FlxSprite;
		
		public var topRightPlatform:FlxSprite;
		public var backTopButtonPlatform:FlxSprite;
		public var backDownButtonPlatform:FlxSprite;
		
		public function PlayState()
		{	
		
		}
		
		override public function create():void
		{
			//BUTTONS
			topButton = new FlxSprite( 0, 171, rawButton );
			topButton.immovable = true;
			
			add( topButton );
			
			bottomButton = new FlxSprite( 0, 519, rawButton );
			bottomButton.immovable = true;
			add( bottomButton );
			
			//DOOR
			door = new FlxSprite( 870, 250, rawDoor );
			door.immovable = true;
			
			//PLATFORMS
			veryTopPlatform = new FlxSprite( 0, -65, rawBottomPlatform );
			veryTopPlatform.acceleration.x = 0;
			veryTopPlatform.immovable = true;
			add( veryTopPlatform );
			
			topPlatform = new FlxSprite( 0, 200, rawPlatform );
			topPlatform.immovable = true;
			add( topPlatform );
			
			bottomPlatform = new FlxSprite( 0, 550, rawBottomPlatform );
			bottomPlatform.immovable = true;
			add( bottomPlatform );
			
			//PLAYERS
			playerOne = new FlxSprite( 330, 300, rawPlayerOne );
			playerOne.acceleration.y = 200;
			playerOne.acceleration.x = 0;
			
			playerTwo = new FlxSprite( 550, 300, rawPlayerTwo );
			playerTwo.acceleration.y = 200;
			playerTwo .acceleration.x = 0;
			
			
			add( playerOne );
			
			add( playerTwo );
		}
		
		override public function update():void
		{
			super.update();
			
			//COLLISION FOR PLAYER TO PLATFORMS
			FlxG.collide( playerOne, bottomPlatform );
			FlxG.collide( playerOne, topPlatform );
			FlxG.collide( playerOne, veryTopPlatform );
			
			FlxG.collide( playerTwo, bottomPlatform );
			FlxG.collide( playerTwo, topPlatform );
			FlxG.collide( playerTwo, veryTopPlatform );
			
			//COLLLSION PLAYERS
			FlxG.collide( playerOne, playerTwo );
			
			//COLLSION FOR PLAYERS AND BUTTONS
			FlxG.collide( playerOne, topButton, function():void
			{
				if(topButton.touching == FlxObject.UP )
				{
					buttonOnePressed = true
				}
			});
			
			FlxG.collide( playerOne, bottomButton, function( player:FlxBasic, button:FlxBasic ):void
			{
				if(bottomButton.touching == FlxObject.UP )
				{
					buttonTwoPressed = true
				}
			});
			
			
			FlxG.collide( playerTwo, topButton, function( player:FlxBasic, button:FlxBasic ):void
			{
				if(topButton.touching == FlxObject.UP )
				{
					buttonOnePressed = true;
				}
				
				
			});
			
			FlxG.collide( playerTwo, bottomButton, function( player:FlxBasic, button:FlxBasic ):void
			{
				if(bottomButton.touching == FlxObject.UP )
				{
					buttonTwoPressed = true
				}
			});
			
			
			//CHECKING COLLISION WITH GREEN SHAPE
			FlxG.collide( playerOne, door, function( player:FlxBasic, door:FlxBasic ):void
			{
				PlayState.playerOneScore++;
				FlxG.switchState( new LevelTwoState() );
			});
			
			FlxG.collide( playerTwo, door, function( player:FlxBasic, door:FlxBasic ):void
			{
				PlayState.playerTwoScore++;
				FlxG.switchState( new LevelTwoState() );
			});
			
			updatePlayers();
			
			//checks if buttons pressed for unlocking the green shape
			checkIfButtonsPressed();
			
		}
		
		public function updatePlayers():void
		{
			updatePlayerOne();
			
			updatePlayerTwo();
		}
		
		public function checkIfButtonsPressed():void
		{
			if( !buttonsPressed )
			{
				if( buttonOnePressed == true && buttonTwoPressed == true )
				{
					add( door );
					
					buttonsPressed = true;
				}
			}
		}
		
		public function updatePlayerOne():void
		{
			//UP
			if( FlxG.keys.W ) { playerOne.acceleration.y = -400;   }
			
			//LEFT
			else if( FlxG.keys.A ) { playerOne.velocity.x = -50; }
			
			//DOWN
			else if( FlxG.keys.S ) { playerOne.acceleration.y = 600;  }
			
			//RIGHT
			else if( FlxG.keys.D ) { playerOne.velocity.x = 50; }
			
			else { playerOne.velocity.x = 0;  } 
		}
		
		public function updatePlayerTwo():void
		{
			//UP
			if( FlxG.keys.UP ) { playerTwo.acceleration.y = -400;   }
				
			//LEFT
			else if( FlxG.keys.LEFT ) { playerTwo.velocity.x = -50; }
				
			//DOWN
			else if( FlxG.keys.DOWN ) { playerTwo.acceleration.y = 600; }
				
			//RIGHT
			else if( FlxG.keys.RIGHT ) { playerTwo.velocity.x = 50; }
				
			else { playerTwo.velocity.x = 0;  } 
		}
	}
}
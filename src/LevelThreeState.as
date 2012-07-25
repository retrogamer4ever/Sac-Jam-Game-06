package
{
	import org.flixel.FlxBasic;
	import org.flixel.FlxG;
	import org.flixel.FlxObject;
	import org.flixel.FlxSprite;
	import org.flixel.FlxState;
	import org.flixel.FlxText;
	
	
	public class LevelThreeState extends FlxState
	{
		[Embed(source="../assets/playerOne.png")] public var rawPlayerOne:Class;
		[Embed(source="../assets/playerTwo.png")] public var rawPlayerTwo:Class;
		
		
		[Embed(source="../assets/platform.png")] public var rawPlatform:Class;
		[Embed(source="../assets/platformLevelTwo.png")] public var rawPlatformLeveltTwo:Class;
		[Embed(source="../assets/bottomPlatform.png")] public var rawBottomPlatform:Class;
		
		
		
		[Embed(source="../assets/button.png")] public var rawButton:Class;
		
		[Embed(source="../assets/doorway.png")] public var rawDoor:Class;
		
		
		
		[Embed(source="../assets/spikes.png")] public var rawSpikes:Class;
		
		public static var playerOneScore:int = 0;
		public static var playerTwoScore:int = 0;
		
		public var buttonOnePressed:Boolean = false;
		public var buttonTwoPressed:Boolean = false;
		public var buttonsPressed:Boolean   = false;
		
		public var topSpikes:FlxSprite;
		
		
		
		
		//DOOR
		public var door:FlxSprite;
		
		
		//BUTTONS
		public var topButton:FlxSprite;
		public var bottomButton:FlxSprite;
		
		//PLAYERS
		public var playerOne:FlxSprite;
		public var playerTwo:FlxSprite;
		
		
		//PLATFORMS
		public var leftPlatform:FlxSprite;
		public var rightPlatform:FlxSprite;
		
		public function LevelThreeState()
		{	
			
		}
		
		override public function create():void
		{
			//SPIKES
			topSpikes = new FlxSprite(0, 0, rawSpikes );
			topSpikes.immovable = true;
			add( topSpikes );
			
			//DOOR
			door = new FlxSprite( 870, 520, rawDoor );
			door.immovable = true;
			add( door );
			
			//PLATFORMS
			leftPlatform = new FlxSprite( 0, 560, rawPlatform );
			leftPlatform.immovable = true;
			add( leftPlatform );
			
			rightPlatform = new FlxSprite( 780, 560, rawPlatform );
			rightPlatform.immovable = true;
			add( rightPlatform );
			
			
			//PLAYERS
			playerOne = new FlxSprite( 120, 300, rawPlayerOne );
			playerOne.acceleration.y = 200;
			playerOne.acceleration.x = 0;
			
			playerTwo = new FlxSprite( 200, 300, rawPlayerTwo );
			playerTwo.acceleration.y = 200;
			playerTwo.acceleration.x = 0;
			
			
			
			
			add( playerOne );
			
			add( playerTwo );
		}
		
		override public function update():void
		{
			super.update();
			
			//COLLISION FOR PLAYER TO PLATFORMS
			FlxG.collide( playerOne, leftPlatform );
			FlxG.collide( playerOne, rightPlatform );
			
			FlxG.collide( playerTwo, leftPlatform );
			FlxG.collide( playerTwo, rightPlatform );
			
			
			//COLLLSION PLAYERS
			FlxG.collide( playerOne, playerTwo );
			
			FlxG.collide( playerTwo, bottomButton );
			FlxG.collide( playerOne, topButton );
			
			//COLLSION FOR PLAYERS AND BUTTONS
			FlxG.collide( playerTwo, topButton, function():void
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
			
			//CHECKING COLLISION SPIKES 
			FlxG.collide( playerOne, topSpikes, function( player:FlxBasic, button:FlxBasic ):void
			{	
				player.kill();
				PlayState.playerTwoScore++;
				FlxG.switchState( new WinState() );
			});
			
			FlxG.collide( playerTwo, topSpikes, function( player:FlxBasic, button:FlxBasic ):void
			{
				player.kill();
				PlayState.playerTwoScore++;
				FlxG.switchState( new WinState() );
			});
			
			
			//CHECKING COLLISION WITH GREEN SHAPE
			FlxG.collide( playerOne, door, function( player:FlxBasic, door:FlxBasic ):void
			{
				PlayState.playerOneScore++;
				FlxG.switchState( new WinState() );
			});
			
			FlxG.collide( playerTwo, door, function( player:FlxBasic, door:FlxBasic ):void
			{
				PlayState.playerTwoScore++;
				FlxG.switchState( new WinState() );
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
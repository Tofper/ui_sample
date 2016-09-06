package data 
{
	/**
	 * ...
	 * @author 
	 */
	public class DataManager 
	{
		public static function getPlayersMinimap(n:uint):Array {
			var player:Array = [];
			for (var i:uint = 0; i < n; i++ ) {
				player.push( { id:i, icon:i, x:100 + i, y:100 + i } );
			}
			return player;
		}
		
		public static function getPlayers(n:uint):Array {
			var player:Array = [];
			for (var i:uint = 0; i < n; i++ ) {
				player.push( { id:i, name:"nickname_" + i.toString(), banned:false, icon:i } );
			}
			return player;
		}
	}

}
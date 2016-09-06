package interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IPlayersListModel extends IEventDispatcher
	{
		function getPlayers():Array;
		function setPlayers(value:Array):void;
		function removePlayer(id:uint):void;
		function setPlayerBanned(id:uint, banned:Boolean):void;
	}
	
}
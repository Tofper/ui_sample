package interfaces 
{
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IPlayersListController
	{
		function setModel(model:IPlayersListModel):void;
		function setView(model:IPlayersListView):void;
	}	
}
package interfaces 
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IPlayersListView extends IEventDispatcher
	{
		function setModel(model:IPlayersListModel):void;
		function get displayObject():DisplayObject;
	}	
}
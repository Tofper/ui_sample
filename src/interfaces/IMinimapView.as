package interfaces 
{
	import flash.display.DisplayObject;
	import flash.events.IEventDispatcher;
	import models.MinimapModel;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IMinimapView extends IEventDispatcher
	{
		function setModel(model:IMinimapModel):void;
	}	
}
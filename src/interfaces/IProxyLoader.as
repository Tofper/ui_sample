package interfaces 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.IEventDispatcher;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IProxyLoader extends IEventDispatcher
	{
		function init(contentName:String, path:String, indicator:MovieClip):void;
		function activate(value:Boolean):void;
		function close(e:Event = null):void;
	}
}
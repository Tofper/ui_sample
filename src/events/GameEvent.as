package events 
{
	import flash.events.Event;
	
	/**
	 * ...
	 * @author 
	 */
	public class GameEvent extends Event 
	{
		private var _data:Object;
		
		public function GameEvent(type:String, data:Object, bubbles:Boolean=false, cancelable:Boolean=false) { 
			super(type, bubbles, cancelable);
			_data = data;			
		} 
		
		public function get data():Object {
			return _data;
		}
		
		public override function clone():Event { 
			return new GameEvent(type, _data, bubbles, cancelable);
		} 
		
		public override function toString():String { 
			return formatToString("GameEvent", "type", "bubbles", "cancelable", "eventPhase"); 
		}
		
	}
	
}
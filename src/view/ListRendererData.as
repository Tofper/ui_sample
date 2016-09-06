package view {	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;	
	
	public class ListRendererData extends MovieClip {
		protected var _data:Object;
		
		public function ListRendererData() {
			super();
		}		
		
		public function setData(value:Object):void {
			_data = value;
			invalidateData();
		}
		
		protected function handleEnterFrameValidation(event:Event):void {
			removeEventListener(Event.ENTER_FRAME, handleEnterFrameValidation, false);
			updateData();
		}
		
		protected function invalidateData():void {
			if  (!hasEventListener(Event.ENTER_FRAME)) {
				addEventListener(Event.ENTER_FRAME, handleEnterFrameValidation, false);
			}
		}
		
		protected function updateData():void {
			
		}
	}
	
}

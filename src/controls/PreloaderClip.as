package controls {
	
	import flash.display.MovieClip;
	
	
	public class PreloaderClip extends MovieClip {		
		
		public var indicator:MovieClip;
		public var background:MovieClip;
		
		public function PreloaderClip() {
			super();
		}
		
		public function setSize(w:int, h:int):PreloaderClip {
			width = w;
			height = h;
			return this;
		}
		
		override public function get width():Number {
			return super.width;
		}
		
		override public function set width(value:Number):void {
			background.width = value;
			indicator.x = background.width / 2;
		}
		
		override public function get height():Number {
			return super.height;
		}
		
		override public function set height(value:Number):void {
			background.height = value;
			indicator.x = background.height / 2;
		}
	
	}
	
}

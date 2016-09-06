package controls {
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.utils.getDefinitionByName;
	
	
	public class VerticalList extends MovieClip {
		protected var _renderers:Array = [];		
		private var _layout:Object = {
			interval:1, margin:0
		};		
		private var _rendererClass:Class;		
		
		public function VerticalList() {
			super();
		}
		
		public function setLayout(value:Object):void {
			_layout = value;
		}
		
		public function cleanUp():void {
			setData(null);
		}
			
		public function set renderer(value:String):void {			
			_rendererClass = getDefinitionByName(value) as Class;
		}
		
		public function setData(value:Array):void {
			if (!_rendererClass) {
				return;
			}
			var renderer:MovieClip;			
			
			var margin:int = _layout.margin;
			var interval:int = _layout.interval;
			var rendererY:uint = margin;
			
			if (value) {
				for (var i:int = 0; i < value.length; ++i) {
					if (!_renderers[i]) {
						renderer =  new _rendererClass();
						_renderers[i] = renderer
					} else {
						renderer = _renderers[i];
					}
					renderer.x = margin;
					renderer.y = rendererY; rendererY += renderer.height + interval;
					renderer.setData(value[i]);
					addChild(renderer);
				}
			}
			
			for (; i < _renderers.length; ++i) {
				renderer = _renderers[i];
				renderer.setData(null);
				removeChild(renderer);
			}
			
			_renderers.length = value ? value.length : 0;
		}
	}
	
}

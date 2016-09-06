package data {

	import flash.display.Bitmap;
	import flash.display.DisplayObjectContainer;
	import flash.display.Sprite;

    public class Icon extends Sprite {
        protected var _bmp:Bitmap;

		// Initialization:
        public function Icon() {
            super();
        }
		
		public function set bitmap(bmp:Bitmap):void {						
			if (_bmp != null) { 
				removeChild(_bmp);			
			}
			_bmp = bmp;
			if (_bmp != null)  {
				addChild(_bmp);
			}
			
        }
		
		public function get bitmap():Bitmap {
			return _bmp;
		}
		
		// меняем иконку на дргую
		public function applyImage(icon:Icon):void {						
			if (icon.bitmap) { bitmap = new Bitmap(icon.bitmap.bitmapData); }
        }       
		
		public function copy():Icon {
			var _clone:Icon = new Icon();			
			if (_bmp) {
				_clone.bitmap = (new Bitmap(_bmp.bitmapData));
			}
			return _clone;
		}
		
		public function clear():void {
			if (!_bmp) { return; }
			_bmp.bitmapData = null;
			removeChild(_bmp);
			_bmp = null; 
		}
			
        override public function toString():String {
            return "[Icon " + name + "_" + (_bmp ? _bmp.bitmapData : "empty") + "]";
        }
    }
}

// Multiton.
package data {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.PixelSnapping;
	import flash.geom.Matrix;
	import flash.geom.Rectangle;
	import flash.utils.Dictionary;

    public class IconContainer {
		
		private static var _instances:Dictionary = new Dictionary();
		
		private var _bitmaps:Vector.<BitmapData> = new Vector.<BitmapData>();
		
		private var _rows:uint = 0;
		private var _columns:uint = 0;
		
		private var _iconWidth:int;
		private var _iconHeight:int;
		private var _vertical:Boolean;	
		
		public static function getInstance(key:String):IconContainer {
			if (!_instances[key]) {
				_instances[key] = new IconContainer();
			}
			return _instances[key];
		}
		
        public function splitBitmapData(iconBitmap:BitmapData, iconW:uint, iconH:uint, vertical:Boolean = false, count:uint = 0, stepH:uint = 0, stepV:uint = 0):void {
			_iconWidth = iconW;
			_iconHeight = iconH;
			var times:int = -1;
			if (count) { times = count; }
			if (iconBitmap) {
				var baseTexture:BitmapData = iconBitmap;
				_columns = Math.floor(baseTexture.width / (iconW + stepH));
				_rows = Math.floor(baseTexture.height / (iconH + stepV));
				
				if (!vertical) {
					for (var r:uint = 0; r < _rows; r++) {					
						for (var c:uint = 0; c < _columns; c++) {						
							createIcon(c, r);
							if (--times == 0) { return; }
						}				
					}
				} else {
					for (c = 0; c < _columns; c++) {					
						for (r = 0; r < _rows; r++) {						
							createIcon(c, r);
							if (--times == 0) { return; }
						}				
					}
				}			
			}
			
			function createIcon(column:int, row:int):void {
				var iconBmpData:BitmapData = new BitmapData(iconW, iconH, true, 0x00000000);	
				var mat:Matrix = new Matrix();					
				mat.translate( -(iconW + stepH) * column - stepH, -(iconH + stepV) * row - stepV);	
				
				iconBmpData.draw(baseTexture, mat, null, null, new Rectangle(0, 0, iconW, iconH));				
				_bitmaps.push(iconBmpData);
			}
        }
		
        public function getBitmapData(index:uint):BitmapData {		
			if (_bitmaps.length <= index) {
				trace("bitmapData index out of bitmapData range", index);
				return null;
			}
			return _bitmaps[index];
		}
		
        public function getIcon(index:uint):Icon {			
			if (_bitmaps.length <= index) {
				trace("bitmapData index out of bitmapData range", index);
				return null;
			}
			
			var bmp:Bitmap = new Bitmap(_bitmaps[index], PixelSnapping.NEVER);			
			bmp.smoothing = true;

			var icon:Icon = new Icon();
			icon.bitmap = bmp;
			return icon;
		}
	
        public function clean():void {
			var l:uint = _bitmaps.length;
			for (var i:uint = 0; i < l; i++ ) {
				var bt:BitmapData = _bitmaps[i];
				bt.dispose();
			}
			_bitmaps.length = 0;
		}
    }
}
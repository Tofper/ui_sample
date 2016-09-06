package view 
{
	import flash.display.Bitmap;
	/**
	 * ...
	 * @author ...
	 */
	public class MinimapObjectRenderer extends ListRendererData {
		public var arrowDraw:Boolean = false;
		public var borderDraw:Boolean = true;
		
		private var _bitmap:Bitmap = new Bitmap();
		
		public function MinimapObjectRenderer() {
			super();			
			_bitmap.x = -10; _bitmap.y = -10; addChild(_bitmap);
		}
		
		override protected function updateData():void {
			if (_data) {
				_bitmap.bitmapData = _data.iconBitmap;
			}
		}
	}

}
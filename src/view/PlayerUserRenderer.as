package view 
{
	import flash.display.Bitmap;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerUserRenderer extends ListRendererData {
		public var textField:TextField;		
		private var _bitmap:Bitmap = new Bitmap();
		
		public function PlayerUserRenderer() {
			super();			
			_bitmap.x = 8; _bitmap.y = 8; addChild(_bitmap);
		}
		
		override protected function updateData():void {
			if (_data) {
				textField.text = "name: " + _data.name + ", activity:" + (_data.banned ? "banned" : "actives");
				_bitmap.bitmapData = _data.iconBitmap;
			}
		}		
	}

}
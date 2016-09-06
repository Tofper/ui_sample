package data 
{
	import flash.display.BitmapData;
	import flash.geom.Point;
	/**
	 * ...
	 * @author 
	 */
	public class MinimapObjectData 
	{
		public var id:int;
		public var position:Point;
		public var iconBitmap:BitmapData;
		public var updated:Boolean;
		public var worldX:int;
		public var worldY:int;
		public var rotation:Number;
		
		public function MinimapObjectData() {
			super();
		}
		
	}

}
package utils {

	public class Mathf {
		public static const TO_DIR:Number = 180 / Math.PI;
		public static const TO_RAD:Number = Math.PI / 180;
		
		public static function pointDirection(x1:Number,y1:Number,x2:Number,y2:Number):Number {
			return Math.atan2(y1 - y2, x2 - x1);
		}
		public static function lenX(len:Number,dir:Number):Number {
			return -len * Math.cos(dir);
		}
		public static function lenY(len:Number,dir:Number):Number {
			return len * Math.sin(dir);
		}
		public static function pointDistance(x1:Number,y1:Number,x2:Number,y2:Number):Number {
			return (x1 - x2 )* (x1 - x2) + (y1 - y2) * (y1 - y2);
		}
	}
}

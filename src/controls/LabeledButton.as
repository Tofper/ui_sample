package controls {
	
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	
	public class LabeledButton extends SimpleButton {		
		private var _states:Array = [];
		public function LabeledButton() {
			super();
			_states = [this.upState, this.overState, this.downState];
		}
		
		public function setLabel(value:String):void {
			var l:uint = _states.length;
			for (var i:uint = 0; i < l; i++ ) {
				var stateRenderer:DisplayObjectContainer = _states[i];
				var textField:TextField = stateRenderer.getChildAt(1) as TextField;
				if (textField) {
					textField.text = value;
				}
			}
		}
	}
	
}

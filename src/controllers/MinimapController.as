package controllers 
{
	import flash.display.Stage;
	import flash.utils.setInterval;
	import interfaces.IMinimapController;
	import interfaces.IMinimapModel;
	import interfaces.IMinimapView;
	import models.MinimapModel;
	/**
	 * ...
	 * @author 
	 */
	public class MinimapController implements IMinimapController {		
		private var _model:IMinimapModel;
		private var _views:Array = [];
		
		private var originPosition:Number = 100;
		private var stage:Stage;
		
		public function MinimapController() {		
			super();
		}
		
		public function setStage(value:Stage):void {
			stage = value;
		}
		
		public function setModel(model:IMinimapModel):void {
			_model = model;
			setInterval(updatePlayers, 10);			
		}
		
		private function updatePlayers():void {
			originPosition += .01;
			var rotationValue:Number = 0;
			if (stage) {
				var mousePosition:Number = (stage.mouseX - (stage.stageWidth / 2));
				rotationValue = mousePosition / (stage.stageWidth / 2) * Math.PI / 2;
			}
			_model.updateLocalPlayerPos(Math.sin(originPosition) * 10 + 100, 100, rotationValue);
		}
		
		public function removeView(viewMinimap:IMinimapView):void {
			viewMinimap.setModel(null);
			_views.slice(_views.indexOf(viewMinimap), 1);
		}
		public function addView(viewMinimap:IMinimapView):void {
			viewMinimap.setModel(_model);
			_views.push(viewMinimap);
		}
	}

}
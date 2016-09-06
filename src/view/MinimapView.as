// Миникарта в игровом интерфейсе
package view {

	import data.MinimapObjectData;
	import events.MinimapEvents;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;
	import flash.utils.Dictionary;
	import flash.utils.getDefinitionByName;
	import interfaces.IMinimapModel;
	import interfaces.IMinimapView;
	import models.MinimapModel;
	import utils.Mathf;


	public class MinimapView extends Sprite implements IMinimapView {	
		public var backMask:MovieClip;
		public var minimapContainer:MovieClip;
		
		private var _rotable:Boolean = false;
		
		private var _renderersDictionary:Dictionary = new Dictionary();		
		private var _renderers:Vector.<MovieClip> = new Vector.<MovieClip>;		
		private var _minimapBitmapData:BitmapData;
		private var _minimapBitmap:Bitmap = new Bitmap();
		
		private var objectContainer:MovieClip;
		
		private var _minimapScale:Number = 1;
		private var _model:IMinimapModel;
		private var radius:int = 90;
		private var radiusPow:int = radius * radius;
		
		private var _minimapRotation:int = 0;
		
		public function MinimapView() {
			mouseChildren = false;
			mouseEnabled = false;

			objectContainer = minimapContainer.objectContainer;
			
			backMask = minimapContainer.backMask;
			
			if (backMask) {
				minimapContainer.mapGround.mask = backMask;
			}
			minimapContainer.mapGround.addChild(_minimapBitmap);
			_minimapBitmap.x = -256;
			_minimapBitmap.y = -256;
		}
		
		public function setModel(model:IMinimapModel):void {
			if (_model) {
				_model.removeEventListener(MinimapEvents.ObjectsUpdated, updateMinimapObjects);
				_model.removeEventListener(MinimapEvents.PropsChanged, updateMinimap);
				_model.removeEventListener(Event.CHANGE, updateMinimapObjects);
				clear();
			}
			_model = model;
			if (_model) {
				_model.addEventListener(MinimapEvents.ObjectsUpdated, updateMinimapObjects);
				_model.addEventListener(MinimapEvents.PropsChanged, updateMinimap);
				_model.addEventListener(Event.CHANGE, updateMinimapObjects);
				
				updateMinimap();
				updateObjects(_model.getObjectsList());
			} else {
				clear();
			}
		}
		
		private function updateMinimapObjects(e:Event = null):void {
			updateObjects(_model.getObjectsList());
		}
		
		private function updateObjects(objects:Vector.<MinimapObjectData>):void {
			var playerRot:Number = _model.getPlayerRotation() * Mathf.TO_RAD;
			var cs:Number = Math.cos(playerRot);
			var sn:Number = Math.sin(playerRot);
			
			var l:int = objects.length;
			for (var i:uint = 0; i < l; i++  ) {
				var rendrer:MovieClip = getRenderer(objects[i]);				
				updateObjectPos(rendrer, objects[i].worldX, objects[i].worldY, objects[i].rotation, cs, sn);
			}
			updateBackground(cs, sn);
			updateBorderObjects();
		}	
		
		private function getRenderer(dataObject:Object):MovieClip {
			var id:int = dataObject.id;
			if (!_renderersDictionary[id]) {
				var rendrer:MovieClip = new MinimapObjectRenderer();
				_renderersDictionary[id] = rendrer;
				rendrer.setData(dataObject);
				objectContainer.addChild(rendrer);
				_renderers.push(rendrer);
				return rendrer;
			} else {
				return _renderersDictionary[id];
			}
			return null;
		}
		
		public function clear():void {
			for (var i:int = 0; i < _renderers.length; i++) {				
				var _inst:MovieClip = _renderers[i];
				if (_inst.borderArrow) {
					removeArrow(_inst);
				}
				objectContainer.removeChild(_inst);
			}			
			_renderers.length = 0;
		}
		
		private function removeObject(target:int):void {
			if (_renderersDictionary[target]) {
				var _inst:MovieClip = _renderersDictionary[target];
				delete _renderersDictionary[target];					
				_renderers.splice(_renderers.indexOf(_inst), 1);
				if (_inst.borderArrow) {
					removeArrow(_inst);
				}
				objectContainer.removeChild(_inst);
			}
		}
		
		public function setRotable(value:Boolean):void {
			_rotable = value;
			if (!value) {
				_minimapRotation = 0;
			}
		}
		
		public function updateMinimap(e:Event = null):void {
			_minimapBitmap.bitmapData = _model.getMinimapBitmap();			
			updateMinimapScale();
		}
		
		private var timeOutAnimation:int = -1;
		
		private var _scaleX:Number = 1;
		private var _scaleY:Number = 1;
		private var _mapBitmap:Bitmap = new Bitmap();
		
		private function updateMinimapScale():void {
			
			var minimapSizeX:int = _model.getMinimapSizeX();
			var minimapSizeY:int = _model.getMinimapSizeY();
			var minimapSize:int = _model.getMinimapSize();
			
			var scaleFactor:Number = Math.min(512 / minimapSize * _minimapScale, 1);
			_scaleX = minimapSize * scaleFactor / minimapSizeX;			
			_scaleY = minimapSize * scaleFactor / minimapSizeY;
			_mapBitmap.scaleX = _mapBitmap.scaleY = scaleFactor;			
		}
		
		public function updateObjectPos(target:MovieClip, posX:Number, posY:Number, rot:Number, cs:Number, sn:Number):void {
			var pos:Point = _model.getPlayerPosition();
			
			var relatedX:Number = -pos.x + posX;
			var relatedY:Number = -pos.y + posY;
			
			target.x = relatedX * cs - relatedY * sn;
			target.y = relatedX * sn + relatedY * cs;
			
			target.x = target.x * _scaleX * _minimapScale;
			target.y = target.y * _scaleY * _minimapScale;
		}
		
		private function updateBackground(cs:Number, sn:Number):void {
			var pos:Point = _model.getPlayerPosition();
			var posGround:Point = _model.getMapPosition();
			var target:MovieClip = minimapContainer.mapGround;
			var posX:Number = posGround.x;
			var posY:Number = posGround.y;
			
			var relatedX:Number = -pos.x + posX;
			var relatedY:Number = -pos.y + posY;
			
			target.rotation = _model.getPlayerRotation();
			target.x = relatedX * cs - relatedY * sn;
			target.y = relatedX * sn + relatedY * cs;
			
			target.x = target.x * _scaleX * _minimapScale;
			target.y = target.y * _scaleY * _minimapScale;
		}
		
		protected function updateBorderObjects():void {			
			for (var i:int = 0; i < _renderers.length; i++) {				
				var renderer:MovieClip = _renderers[i];
				
				var dist:Number = Mathf.pointDistance(renderer.x, renderer.y, 0, 0);
				if ((renderer.borderDraw || renderer.arrowDraw) && dist > radiusPow) {
					var direction:Number = Mathf.pointDirection(renderer.x, renderer.y, 0, 0);
					renderer.x = Mathf.lenX(radius, direction);
					renderer.y = Mathf.lenY(radius, direction);
					
					if (renderer.arrowDraw) {
						renderer.visible = false;
						addArrow(renderer, direction);						
					} else {
						// Change alpha over distance;
						renderer.alpha = Math.max(1 - ((dist - radiusPow) / radiusPow), 0);
					}	
				} else {
					if (renderer.arrowDraw) {
						removeArrow(renderer)
					}
					renderer.alpha = 1;
					renderer.visible = true;
				}
			}
		}
		
		private var _arrows:Object = new Object();
		protected function addArrow(_inst:MovieClip, dir:Number):void {
			if (!_arrows[_inst]) {				
				var type:Class = getDefinitionByName("target_arrow") as Class;
				var arrow:MovieClip = new type();
				_arrows[_inst] = arrow;
				objectContainer.addChild(arrow);
			} else {
				arrow = _arrows[_inst];
			}
			arrow.rotation = -(dir * Mathf.TO_DIR) - 90;
			arrow.x = _inst.x;
			arrow.y = _inst.y;			
		}
		
		protected function removeArrow(_inst:MovieClip):void {
			if (_arrows[_inst]) {
				var arrow:MovieClip = _arrows[_inst];
				objectContainer.removeChild(arrow);
				_arrows[_inst] = null;
			}
		}
	}

}
// Миникарта в игровом интерфейсе
package models {

	import data.IconContainer;
	import data.MinimapObjectData;
	import events.MinimapEvents;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.net.URLRequest;
	import flash.utils.Dictionary;
	import interfaces.IMinimapModel;
	import utils.Mathf;


	public class MinimapModel extends EventDispatcher implements IMinimapModel {		
		// Позиция игрока.
		private var _playerX:Number = 0;
		private var _playerY:Number = 0;
		private var _playerRotation:Number = 0;
		
		// Размер карты в игровых единицах
		private var _mapSizeX:Number;
		private var _mapSizeY:Number;
		
		// Стартовая позиция битмапы в игровом мире.
		private var _mapPositionX:Number = 0;
		private var _mapPositionY:Number = 0;		
		
		private var _dictDynamic:Dictionary = new Dictionary(true);		
		private var _objectsDynamic:Vector.<MinimapObjectData> = new Vector.<MinimapObjectData>;	
		
		private var _dataPlayers:Array;	
		private var _minimapSettings:Object = new Object();
		
		private var minimapSize:int = 512;
		
		private var _minimapBitmap:BitmapData = null;
		private var _minimapName:String = null;
		private var _minimapNameUrl:String = null;
		private var loader:Loader;	
		
		public function MinimapModel() {
			super();
		}
		
		public function getPlayerRotation():Number {
			return _playerRotation;
		}
		public function getPlayerPosition():Point {
			return new Point(_playerX, _playerY);
		}
		public function getMapPosition():Point {
			return new Point(_mapPositionX, _mapPositionY);
		}
		public function getMinimapSize():int {
			return minimapSize;
		}
		public function getMinimapSizeY():int {
			return _mapSizeY;
		}
		public function getMinimapSizeX():int {
			return _mapSizeX;
		}
		public function getMinimapBitmap():BitmapData {
			return _minimapBitmap;
		}
		
		public function getObjectsList():Vector.<MinimapObjectData> {
			return _objectsDynamic;
		}
		
		public function initSettings(value:Object):void {
			_minimapSettings = value;
			_minimapName = _minimapSettings.map;
			
			_mapSizeX = _minimapSettings.size * 2;
			_mapSizeY = _minimapSettings.size * 2;
			
			_mapPositionX = _minimapSettings.x - _minimapSettings.size;
			_mapPositionY = _minimapSettings.y - _minimapSettings.size;
			
			loadMapBackground(_minimapSettings.map);
		}
		
		public function getMinimapData():Object {
			return {
				name:_minimapName,
				bitmap:_minimapBitmap,
				mapPosX:_mapPositionX,
				mapPosY:_mapPositionY,
				size:minimapSize
			}
		}
		
		public function clear():void {
			_dictDynamic = new Dictionary(true);
		}
		
		public function setPlayersData(value:Array):void {
			_dataPlayers = value;
			var l:uint =  _dataPlayers.length;
			for (var i:int = 0; i <l; i++) {				
				var playerData:Object = _dataPlayers[i];
				if (!_dictDynamic[playerData.id]) {					
					registerObject(playerData, _dictDynamic, _objectsDynamic);			
				} else {
					updateObjectPos(playerData, _dictDynamic);
				}
			}
			clearObjects(_dictDynamic, _objectsDynamic);
			invalidateObjectsData();
			dispatchEvent(new Event(MinimapEvents.ObjectsUpdated));
		}
		
		public function updateLocalPlayerPos(posX:Number, posY:Number, rot:Number = 0):void {		
			_playerX = posX;
		    _playerY = posY;
			_playerRotation = rot * Mathf.TO_DIR;	
			invalidateObjectsData();			
		}
		
		private function updateObjectPos(dataObject:Object, target:Dictionary):void {
			var _objects:Dictionary = target;
			var _inst:MinimapObjectData = _objects[dataObject.id];
			_inst.worldX = dataObject.x;
			_inst.worldY = dataObject.y;
			_inst.rotation = -dataObject.rotation * Mathf.TO_DIR;
			_inst.updated = true;
		}
		
		private function clearObjects(target:Dictionary, vector:Vector.<MinimapObjectData>):void {
			var objects:Dictionary = target;
			var toDelete:Array = null; 
			for each(var _inst:Object in objects) {
				if (!_inst.updated) {	
					if (!toDelete) { toDelete = []; }
					toDelete.push(_inst.index);
				}
			}
			
			if (toDelete) {
				var l:uint = toDelete.length;
				for (var i:int = 0; i < l; i++) {
					delete objects[toDelete[i]];	
					vector.splice(vector.indexOf(toDelete[i]), 1);
				}
				dispatchEvent(new Event(MinimapEvents.ObjectsUpdated));
			}
		}
		
		private function loadMapBackground(map:String):void {			
			createImageLoader("assets/" + map);			
		}
		
		private function createImageLoader(value:String):void {
			if (value == _minimapNameUrl) {
				return;
			}
			_minimapNameUrl = value;			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoad, false, 0, true);
			loader.load(new URLRequest(value));
		}		
		
		private function onCompleteLoad(event:Event):void {	
			var bitmapData:BitmapData;
			var loaderInfo:LoaderInfo;
			loaderInfo = LoaderInfo(event.target);
			loader = loaderInfo.loader;
			var loadedBitmapData:BitmapData = Bitmap(loaderInfo.content).bitmapData;
			minimapSize = loadedBitmapData.width;
			//Хендлим миникрты неправильного размера
			//var matrix:Matrix = new Matrix();
			//var scale:Number = Math.min(512 / loadedBitmapData.width, 1);
			//matrix.scale(scale, scale);			
			//defBitmapData.fillRect(new Rectangle(0, 0, defBitmapData.width, defBitmapData.height), 0);
			//defBitmapData.draw(loadedBitmapData, null, null, null, null, true);
			_minimapBitmap = loadedBitmapData;
			loaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoad);
			loader.unloadAndStop();			
			loader = null;
			dispatchEvent(new Event(MinimapEvents.PropsChanged));
		}			
		
		protected function invalidateObjectsData():void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		protected function registerObject(dataObject:Object, target:Dictionary, vector:Vector.<MinimapObjectData>):void {			
			var _objects:Dictionary = target;
			var id:int = dataObject.id;			
			
			var _inst:MinimapObjectData = new MinimapObjectData();
			_inst.id = dataObject.id;
			_inst.iconBitmap = IconContainer.getInstance("smiles").getBitmapData(dataObject.icon);
			_inst.updated = true;
			_inst.worldX = dataObject.x;
			_inst.worldY = dataObject.y;
			_objects[id] = _inst;
			
			vector.push(_inst);
		}
	}

}
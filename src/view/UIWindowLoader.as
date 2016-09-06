package view {
	import data.LoadManager;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.system.System;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	import interfaces.IProxyLoader;
	
	public class UIWindowLoader extends MovieClip implements IProxyLoader {
		
		public static const UNLOAD_DELAY:uint = 6000;
		
		private var loadIndicator:MovieClip;
		
		private var _loaded:Boolean = false;
		private var _loadManager:LoadManager;
		private var _loaderCommandsList:Array = [];
		private var _contentName:String;
		private var _path:String;
		private var _loader:Loader;
		
		protected var _timer:Timer;
		protected var _content:MovieClip;
		protected var _state:Object = null;
		protected var _functionsDict:Dictionary = new Dictionary();
		
		public function UIWindowLoader() {
			super();
		}
		
		public function init(contentName:String, path:String, indicator:MovieClip):void {
			_contentName = contentName;
			_path = path;
			_timer = new Timer(UIWindowLoader.UNLOAD_DELAY, 1);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, onTimerComplete);
			
			if (indicator) {
				loadIndicator = indicator;
			}
		}
		
		protected function load():void {
			if (!_timer) {
				throw new Error("UIWindlowLoader was not initialized, call init() first");
			}
			
			_loadManager = new LoadManager();
			_loader = _loadManager.load(_path, addContentToStage);
			if (loadIndicator) {
				addChild(loadIndicator);
			}
		}
		
		protected function unload():void {
			if (!_content) {
				return;
			}
			
			_state = _content.saveState();
			_content.cleanUp();
			removeChild(_content);
			
			_loader.unloadAndStop();
			_loader = null;
			_loadManager = null;
			_content = null;
			_loaded = false;
			
			trace(_contentName + " was unloaded", System.totalMemory);
		}
		
		private function addContentToStage():void {
			_content = _contentName ? new (getDefinitionByName(_contentName) as Class)() : _loader.content as MovieClip;
			
			addChild(_content);
			
			_content.visible = false;
			
			addEventListener(Event.ENTER_FRAME, handleUIWindowLoaded);
		}
		
		private function handleUIWindowLoaded(e:Event = null):void {
			removeEventListener(Event.ENTER_FRAME, handleUIWindowLoaded);
			
			_content.visible = true;
			
			initContent();
			
			for (var i:uint = 0; i < _loaderCommandsList.length; i++) {
				_loaderCommandsList[i]();
			}
			_loaderCommandsList.length = 0;
			
			_loaded = true;
			
			if (loadIndicator) {
				removeChild(loadIndicator);
			}
		}
		
		protected function initContent():void {}
		
		public function get loaded():Boolean {
			return _loaded;
		}
		
		protected function addCommand(value:Function, reset:Boolean = false):void {
			_loaderCommandsList.push(value);
		}
		
		private function onTimerComplete(e:TimerEvent):void {
			unload();
		}
		
		public function activate(value:Boolean):void {
			(value) ? _timer.reset() : _timer.start();
			if (!loaded && value) {
				load();
			}
		}
		
		public function close(e:Event = null):void {
			_timer.start();
		}
	
	}

}
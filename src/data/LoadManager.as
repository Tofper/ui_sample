package  data {
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.events.Event;
	import flash.net.URLRequest;
	import flash.system.ApplicationDomain;
	import flash.system.LoaderContext;
	
	public class LoadManager {
		private var _loaded:Boolean = false;
		
		private var _loadContent:* = null;		
		private var _loaderInfo:LoaderInfo;
		private var _loader:Loader;
		private var _loaderCompleteCall:Function;
		
		public function LoadManager() {
			super();
		}
		
		public function load(path:String, f:Function):Loader {			
			_loader = new Loader();
			_loader.load(new URLRequest(path), new LoaderContext(false, ApplicationDomain.currentDomain));
			_loader.contentLoaderInfo.addEventListener(Event.COMPLETE, onCompleteLoad);
			_loaderCompleteCall = f;
			return _loader;
		}
		
		public function cleanUp():void {
			_loader = null;
			_loaderInfo = null;
			_loaderCompleteCall = null;
			_loadContent = null;
		}
		
		private function onCompleteLoad(event:Event):void {	
			_loaded = true;
			_loaderInfo = LoaderInfo(event.target);
			_loader = _loaderInfo.loader;
			_loadContent = _loader.content;
			_loader.contentLoaderInfo.removeEventListener(Event.COMPLETE, onCompleteLoad);
			_loader.dispatchEvent(new Event(Event.ADDED));
			if (_loaderCompleteCall is Function) {
				_loaderCompleteCall();
			}
			cleanUp();
		}
	}

}
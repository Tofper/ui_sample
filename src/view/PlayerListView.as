//
// 
//
package view {
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.events.Event;
	import interfaces.IPlayersListModel;
	import interfaces.IPlayersListView;

	public class PlayerListView extends MovieClip implements IPlayersListView {
		public var list:*;		
		private var _model:IPlayersListModel;
		
		public function PlayerListView () {			
			super();			
			addEventListener(Event.REMOVED_FROM_STAGE, clean);
		}
		
		public function setModel(model:IPlayersListModel):void {
			_model = model;
			if (_model) {
				_model.addEventListener(Event.CHANGE, handlePlyersListUpdate);
				handlePlyersListUpdate();
			}
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
		
		private function clean(e:Event):void {
			removeEventListener(Event.REMOVED_FROM_STAGE, clean);
			_model.removeEventListener(Event.CHANGE, handlePlyersListUpdate);
			_model = null;		
		}
		
		private function handlePlyersListUpdate(event:Event = null):void {
			list.setData(_model.getPlayers());
		}
		
		
		
	}
}

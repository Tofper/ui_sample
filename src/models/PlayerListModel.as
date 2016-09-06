//
// D:\survarium\resources\sources\ui\sources\lobby_menu.swc\survarium\controls\AmmoTipRenderer
//
package models {
	import data.IconContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.TimerEvent;
	import flash.utils.Dictionary;
	import flash.utils.Timer;
	import interfaces.IPlayersListModel;

	public class PlayerListModel extends EventDispatcher implements IPlayersListModel {
		private var _players:Array;
		private var _playersDictionary:Dictionary = new Dictionary();
		
		public function PlayerListModel () {
			super();
		}
		
		public function getPlayers():Array {
			return _players;
		}
		
		public function setPlayers(value:Array):void {
			clean();
			_players = value;
			var l:uint = value.length;
			for (var i:uint = 0; i < l; i++ ) {
				var playerData:Object = _players[i];
				playerData.iconBitmap = IconContainer.getInstance("smiles").getBitmapData(playerData.icon);
				_playersDictionary[_players[i].id] = _players[i];
			}
			invalidateData();
		}	
		
		public function removePlayer(id:uint):void {
			_players.splice(getPlayerIndex(id), 1);
			delete _playersDictionary[id];
			invalidateData();
		}
		
		public function setPlayerBanned(id:uint, banned:Boolean):void {
			_playersDictionary[id].banned = banned;
			invalidateData();
		}
		
		private function getPlayerIndex(id:uint):uint {
			var l:uint = _players.length;
			for (var i:uint = 0; i < l; i++ ) {
				if (_players[i].id == id) {
					return i;
				}
			}
			return 0;
		}
		
		private function invalidateData():void {
			dispatchEvent(new Event(Event.CHANGE));
		}
		
		private function clean():void {
			if (_players) {
				var l:uint = _players.length;
				for (var i:uint = 0; i < l; i++ ) {
					delete _playersDictionary[_players[i].id];
				}
			}
		}
		
	}
}

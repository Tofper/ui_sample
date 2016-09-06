package controllers 
{
	import events.GameEvent;
	import events.PlayerViewEvents;
	import flash.events.Event;
	import interfaces.IPlayersListController;
	import interfaces.IPlayersListModel;
	import interfaces.IPlayersListView;
	import models.PlayerListModel;
	import view.PlayerListView;
	/**
	 * ...
	 * @author 
	 */
	public class PlayerListController implements IPlayersListController {		
		private var _model:IPlayersListModel;
		private var _view:IPlayersListView;
		
		public function PlayerListController() {		
			super();
		}
		
		public function setModel(model:IPlayersListModel):void {
			_model = model;
		}
		public function setView(view:IPlayersListView):void {
			_view = view;
			_view.addEventListener(PlayerViewEvents.BAN_PLAYER, handleBanPlayer);
			_view.addEventListener(PlayerViewEvents.REMOVE_PLAYER, handleRemovePlayer);
		}
		
		private function handleRemovePlayer(e:GameEvent):void {
			_model.removePlayer(e.data.id);
		}
		private function handleBanPlayer(e:GameEvent):void {
			_model.setPlayerBanned(e.data.id, !e.data.banned);
		}
	}

}
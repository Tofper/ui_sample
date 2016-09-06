package view 
{
	import flash.display.DisplayObject;
	import interfaces.IPlayersListModel;
	import interfaces.IPlayersListView;
	import models.PlayerListModel;
	/**
	 * ...
	 * @author 
	 */
	public class PlayerListProxy extends UIWindowLoader implements IPlayersListView
	{
		private var _model:IPlayersListModel;
		private var _controller:*;
		
		public function PlayerListProxy():void	{
			super();			
		}
		
		public function setModel(model:IPlayersListModel):void {
			_model = model;
			if (_content) {
				var viewList:IPlayersListView = _content as IPlayersListView;
				viewList.setModel(model);
			}
		}
		
		override protected function initContent():void {
			super.initContent();
			var viewList:IPlayersListView = _content as IPlayersListView;
			viewList.setModel(_model);			
		}
		
		public function get displayObject():DisplayObject {
			return this;
		}
	}

}
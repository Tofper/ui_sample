package
{
	import controllers.MinimapController;
	import controllers.PlayerListController;
	import controls.VerticalList;
	import data.DataManager;
	import data.IconContainer;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.setTimeout;
	import interfaces.IMinimapController;
	import interfaces.IMinimapModel;
	import interfaces.IPlayersListModel;
	import interfaces.IPlayersListView;
	import interfaces.IProxyLoader;
	import models.MinimapModel;
	import models.PlayerListModel;
	import view.MinimapView;
	import view.PlayerListProxy;
	import view.PlayerListView;
	
	/**
	 * ...
	 * @author 
	 */
	public class Main extends Sprite 
	{
		private var playersModel:IPlayersListModel = new PlayerListModel();
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			PlayerListView; VerticalList;
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			var iconsContainer:IconContainer = IconContainer.getInstance("smiles");
			[Embed(source = "assets/sprites.png")]
			var ModifierIcons:Class;
			var bitmapData:BitmapData = (new ModifierIcons() as Bitmap).bitmapData;
			iconsContainer.splitBitmapData(bitmapData, 20, 20);
			
			
			var playersDebugView:IPlayersListView = new PlayerListProxy();	
			
			playersDebugView.setModel(playersModel);
			
			var playerListController:PlayerListController = new PlayerListController();
			playerListController.setModel(playersModel);
			playerListController.setView(playersDebugView);
			
			if (playersDebugView is IProxyLoader) {
				(playersDebugView as IProxyLoader).init("", "listViewDebug.swf", new PreloaderWidget().setSize(522, 380));
				(playersDebugView as IProxyLoader).activate(true);			
			}
			
			var playersUserView:IPlayersListView = new PlayerListProxy();	
			playersUserView.setModel(playersModel);
			if (playersUserView is IProxyLoader) {
				(playersUserView as IProxyLoader).init("", "listViewUser.swf", new PreloaderWidget().setSize(401, 380));
				(playersUserView as IProxyLoader).activate(true);			
			}
			
			addChild(playersUserView.displayObject);			
			playersDebugView.displayObject.x = 410;
			addChild(playersDebugView.displayObject);
			
			playersModel.setPlayers(DataManager.getPlayers(4));
			
			var minimapModel:IMinimapModel = new MinimapModel();
			minimapModel.initSettings( { size:20, map:"minimap.png", x:120, y:120 } );
			minimapModel.setPlayersData(DataManager.getPlayersMinimap(6));
			minimapModel.updateLocalPlayerPos(100, 100);
			
			var minimaView:MinimapView = new SrvMinimapLite();
			minimaView.y = 400;
			minimaView.x = 80;			
			addChild(minimaView);
			
			var minimapController:IMinimapController = new MinimapController();
			minimapController.setModel(minimapModel);
			minimapController.addView(minimaView);
			minimapController.setStage(stage);
		}
		
	}
	
}
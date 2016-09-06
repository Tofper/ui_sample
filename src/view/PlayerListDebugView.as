package view 
{
	/**
	 * ...
	 * @author 
	 */
	public class PlayerListDebugView extends PlayerListView {		
		public function PlayerListDebugView() {
			super();
			list.renderer = "SrvListRendererDebug";
			list.setLayout({margin:15, interval:1})
		}		
	}
}
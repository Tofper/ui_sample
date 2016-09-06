package view 
{
	/**
	 * ...
	 * @author 
	 */
	public class PlayerListUserView extends PlayerListView {
		public function PlayerListUserView() {
			super();
			list.renderer = "SrvListRendererUser";
			list.setLayout({margin:15, interval:1})
		}		
	}
}
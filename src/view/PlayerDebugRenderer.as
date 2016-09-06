package view 
{
	import controls.LabeledButton;
	import events.GameEvent;
	import events.PlayerViewEvents;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	/**
	 * ...
	 * @author ...
	 */
	public class PlayerDebugRenderer extends ListRendererData 
	{
		public var textField:TextField;
		public var buttonBan:LabeledButton;
		public var buttonRemove:LabeledButton;
		
		public function PlayerDebugRenderer() {
			super();			
			buttonBan.setLabel("ban");
			buttonRemove.setLabel("remove");
			buttonBan.addEventListener(MouseEvent.CLICK, handleButtonClicked, false, 0, true);
			buttonRemove.addEventListener(MouseEvent.CLICK, handleButtonClicked, false, 0, true);
		}
		
		private function handleButtonClicked(e:MouseEvent):void {
			if (e.target == buttonBan) {
				dispatchEvent(new GameEvent(PlayerViewEvents.BAN_PLAYER, _data, true));
			} else {
				dispatchEvent(new GameEvent(PlayerViewEvents.REMOVE_PLAYER, _data, true));
			}
		}
		
		override protected function updateData():void {
			if (_data) {
				mouseEnabled = true;
				textField.text = "id: " + _data.id + ", ban:" + _data.banned;
				buttonBan.setLabel( _data.banned ? "unban" : "ban");
			} else {
				mouseEnabled = false;
				textField.text = "";
				buttonBan.visible = buttonRemove.visible = false;
			}
		}
		
	}

}
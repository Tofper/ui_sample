package interfaces 
{
	import flash.display.Stage;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IMinimapController	{
		function setModel(model:IMinimapModel):void;
		function addView(model:IMinimapView):void;
		function removeView(model:IMinimapView):void;
		function setStage(value:Stage):void;
	}
}
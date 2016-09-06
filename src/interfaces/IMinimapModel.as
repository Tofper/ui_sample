package interfaces 
{
	import data.MinimapObjectData;
	import flash.display.BitmapData;
	import flash.events.IEventDispatcher;
	import flash.geom.Point;
	import models.MinimapModel;
	
	/**
	 * ...
	 * @author 
	 */
	public interface IMinimapModel extends IEventDispatcher
	{
		function getPlayerRotation():Number;
		function getPlayerPosition():Point;
		function getMapPosition():Point;
		function getMinimapSize():int;
		function getMinimapSizeY():int;
		function getMinimapSizeX():int;
		function getMinimapBitmap():BitmapData;
		function getObjectsList():Vector.<MinimapObjectData> ;
		function initSettings(value:Object):void;
		function getMinimapData():Object;
		function clear():void;
		function setPlayersData(value:Array):void;
		function updateLocalPlayerPos(posX:Number, posY:Number, rot:Number = 0):void;
	}	
}
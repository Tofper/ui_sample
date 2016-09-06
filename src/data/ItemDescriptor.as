package data {
	
	import flash.external.*;
	import flash.utils.Dictionary;
	import survarium.constants.Category;

	public class ItemDescriptor {
		//End of Debug Variables
		protected static var _descriptors:Object = new Object();
		
		protected var _itemDescriptors:Dictionary; // В этом массиве хранятся описания всех предметов, которые могут быть отображены в UI.				
		protected var _descriptorName:String;
		
		//Constructor
		public function ItemDescriptor(descriptorName:String):void {
			_descriptorName = descriptorName;
			_descriptors[_descriptorName] = this
		}
		
		public static function getItemDescriptor(descriptorName:String):ItemDescriptor {
			return _descriptors[descriptorName]
		}
		
		//ITEMS DICTIONARY		
		public function getItemsDictionary():Dictionary {
			return _itemDescriptors;
		}
		public function setItemsDictionary(d:Array):void {
			if (d==null) {return};
			
			_itemDescriptors = new Dictionary();
			for (var i:uint = 0; i < d.length; i++) {				
				if (d[i].is_stack && d[i].clip_size == undefined) {					
					d[i].clip_size = 1;
				}
				_itemDescriptors[d[i].dictId] = d[i];				
				if ( d[i].item_properties == null ) { continue; }
			}
		}
		
		public function getItemDescription(dictId:uint):Object {
			if (_itemDescriptors[dictId] == null) { stackTrace("Wrong dictId [" + dictId + "] in getItemDescription"); return new Object(); }
			return _itemDescriptors[dictId];
		}
	}
}

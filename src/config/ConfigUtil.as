package config {
	import events.LayoutEvent;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import model.YuanJian;
	import model.YuanJianManager;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class ConfigUtil extends EventDispatcher {
		
		private static var _instance:ConfigUtil;
		
		private var _xml:XML;
		
		public function ConfigUtil() {
		
		}
		
		public function loadXML():void {
			var url:URLRequest = new URLRequest("ImportData.xml");
			var loadurl:URLLoader = new URLLoader(url);
			loadurl.addEventListener(Event.COMPLETE, _Loadxml);
		}
		
		private function _Loadxml(e:Event):void {
			var loadurl:URLLoader = e.currentTarget as URLLoader;
			loadurl.removeEventListener(Event.COMPLETE, _Loadxml);
			_xml = XML(loadurl.data);
			
			YuanJianManager.instance.itemArr.length = 0;
			var tempArr:Array = null;
			var tempArr1:Array = null;
			for each (var item:* in _xml.items.item) {
				// <item name="DK01" code="NUM0001" type="DK" rgb="255,0,0" size="50,50" />
				tempArr = item.@size.split(',');
				tempArr1 = item.@rgb.split(',');
				YuanJianManager.instance.itemArr.push(new YuanJian(int(tempArr[0]), int(tempArr[1]), ColorUtil.rgbToNumber(int(tempArr1[0]), int(tempArr1[1]), int(tempArr1[2])), item.@name));
			}
			
			this.dispatchEvent(new LayoutEvent(LayoutEvent.IMPORT_XML_OK, _xml));
		}
		
		public static function get instance():ConfigUtil {
			if (!ConfigUtil._instance) {
				ConfigUtil._instance = new ConfigUtil();
			}
			return ConfigUtil._instance;
		}
	
	}

}
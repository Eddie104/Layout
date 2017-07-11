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
		
		private var _layoutXML:XML;
		
		private var _layoutName:String = '';
		
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
			
			YuanJianManager.instance.clear();
			var tempArr:Array = null;
			var tempArr1:Array = null;
			for each (var item:* in _xml.items.item) {
				// <item name="DK01" code="NUM0001" type="DK" rgb="255,0,0" size="50,50" />
				tempArr = item.@size.split(',');
				tempArr1 = item.@rgb.split(',');
				YuanJianManager.instance.itemArr.push(new YuanJian(int(tempArr[0]), int(tempArr[1]), ColorUtil.rgbToNumber(int(tempArr1[0]), int(tempArr1[1]), int(tempArr1[2])), item.@name, item.@code));
			}
			
			_layoutName = _xml.layout.@name;
			if (_layoutName) {
				loadurl.load(new URLRequest(_layoutName + '.xml'));
				loadurl.addEventListener(Event.COMPLETE, _loadLayoutxml);
			} else {
				this.dispatchEvent(new LayoutEvent(LayoutEvent.IMPORT_XML_OK, _xml));
			}
		}
		
		private function _loadLayoutxml(e:Event):void {
			var loadurl:URLLoader = e.currentTarget as URLLoader;
			loadurl.removeEventListener(Event.COMPLETE, _loadLayoutxml);
			_layoutXML = XML(loadurl.data);
			
			for each (var item:* in _layoutXML.items.item) {
				if (item.@name != 'kaKou') {
					if (!YuanJianManager.instance.getYuanJian(item.@name)) {
						YuanJianManager.instance.itemArr.push(new YuanJian(int(item.@w), int(item.@h), int(item.@color), item.@name, item.@code));
					}
				}
			}
			
			this.dispatchEvent(new LayoutEvent(LayoutEvent.IMPORT_XML_OK, _xml, null, false, null, _layoutXML));
		}
		
		public static function get instance():ConfigUtil {
			if (!ConfigUtil._instance) {
				ConfigUtil._instance = new ConfigUtil();
			}
			return ConfigUtil._instance;
		}
		
		public function get layoutName():String {
			return _layoutName;
		}
		
		public function set layoutName(value:String):void {
			_layoutName = value;
		}
		
		public function get xml():XML {
			return _xml;
		}
		
		public function get layoutXML():XML {
			return _layoutXML;
		}
	
	}

}
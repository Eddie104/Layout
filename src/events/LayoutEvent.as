package events {
	import flash.events.Event;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class LayoutEvent extends Event {
		
		public static const IMPORT_XML:String = 'importXML';
		
		public static const IMPORT_XML_OK:String = 'importXMLOK';
		
		public static const ADD_XIAN_CAO:String = 'addXianCao';
		
		public static const ADD_GUI_DAO:String = 'addGuiDao';
		
		public static const SELECTED_ARR_CHANGED:String = 'selectedArrChanged';
		
		private var _xml:XML;
		
		public function LayoutEvent(type:String, xml:XML = null, bubbles:Boolean = false, cancelable:Boolean = false) {
			super(type, bubbles, cancelable);
			_xml = xml;
		}
		
		public function get xml():XML{
			return _xml;
		}
		
		public override function clone():Event {
			return new LayoutEvent(type, _xml, bubbles, cancelable);
		}
		
		public override function toString():String {
			return formatToString("LayoutEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}
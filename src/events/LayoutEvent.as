package events {
	import flash.events.Event;
	import model.Cell;
	import model.YuanJian;
	
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
		
		static public const START_TO_DTAG_YUAN_JIAN:String = "startToDtagYuanJian";
		
		static public const SHOW_YUAN_JIAN_SHU_XING:String = "showYuanJianShuXing";
		
		static public const ADD_JIA_GUI_DAO:String = "addJiaGuiDao";
		
		static public const UPDATE_CELL:String = "updateCell";
		
		static public const COPY:String = 'copy';
		
		static public const DELETE:String = "delete";
		
		static public const RESET_YUAN_JIAN:String = "resetYuanJian";
		
		static public const START_TO_DTAG_V_XIAN_CAO:String = "startToDtagVXianCao";
		
		static public const START_TO_DTAG_H_XIAN_CAO:String = "startToDtagHXianCao";
		
		static public const START_TO_DTAG_GUI_DAO:String = "startToDtagGuiDao";
		
		static public const START_TO_DTAG_KA_KOU:String = "startToDtagKaKou";
		
		static public const START_TO_DTAG_JIA_GUI_DAO:String = "startToDtagJiaGuiDao";
		
		static public const YUAN_JIAN_QU_INITED:String = "yuanJianQuInited";
		
		private var _xml:XML;
		
		private var _yuanJian:YuanJian;
		
		private var _isCtrlKey:Boolean;
		
		private var _cell:Cell;
		
		private var _layoutXML:XML;
		
		public function LayoutEvent(type:String, xml:XML = null, yuanJian:YuanJian = null, isCtrlKey:Boolean = false, cell:Cell = null, layoutXML:XML = null) {
			super(type);
			_xml = xml;
			_yuanJian = yuanJian;
			_isCtrlKey = isCtrlKey;
			_cell = cell;
			_layoutXML = layoutXML;
		}
		
		public function get xml():XML{
			return _xml;
		}
		
		public function get yuanJian():YuanJian {
			return _yuanJian;
		}
		
		public function get isCtrlKey():Boolean {
			return _isCtrlKey;
		}
		
		public function get cell():Cell {
			return _cell;
		}
		
		public function get layoutXML():XML {
			return _layoutXML;
		}
		
		public override function clone():Event {
			return new LayoutEvent(type, _xml, _yuanJian, _isCtrlKey, _cell, _layoutXML);
		}
		
		public override function toString():String {
			return formatToString("LayoutEvent", "type", "bubbles", "cancelable", "eventPhase");
		}
	
	}

}
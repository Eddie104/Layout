package model {
	/**
	 * ...
	 * @author hongjie
	 */
	public final class KaKou extends YuanJian {
		
		private var _typeStr:String = '';
		
		public function KaKou(width:int, height:int, type:String = '') {
			super(width, height, 0x00b050, '卡扣', 'kaKou');
			_typeStr = type;
			_isKaKou = true;
		}
		
		public function get typeStr():String {
			return _typeStr;
		}
		
		public function set typeStr(value:String):void {
			_typeStr = value;
		}
		
		override public function toXML():String {
			return '<item code="kaKou" name="kaKou" type="' + _typeStr + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" w="' + this.reallyWidth + '" h="' + reallyHeight + '" />';
		}
		
	}

}
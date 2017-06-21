package model {
	/**
	 * ...
	 * @author hongjie
	 */
	public final class KaKou extends YuanJian {
		
		public function KaKou(width:int, height:int) {
			super(width, height, 0x00b050, '卡扣');
			_isKaKou = true;
		}
		
		override public function toXML():String {
			return '<item name="kaKou" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" w="' + this.reallyWidth + '" h="' + reallyHeight + '" />';
		}
		
	}

}
package model {
	/**
	 * ...
	 * @author hongjie
	 */
	public final class YuanJian extends Cell {
		
		private var _offsetX:int;
		
		private var _guiDao:GuiDao;
		
		public function YuanJian(width:int, height:int, color:int, name:String) {
			super(width, height, color);
			this.name = name;
		}
		
		public function get offsetX():int {
			return _offsetX;
		}
		
		public function set offsetX(value:int):void {
			_offsetX = value;
			_guiDao.resetYuanJian();
		}
		
		public function get guiDao():GuiDao {
			return _guiDao;
		}
		
		public function set guiDao(value:GuiDao):void {
			_guiDao = value;
		}
		
	}

}
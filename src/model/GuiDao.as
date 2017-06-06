package model {
	/**
	 * ...
	 * @author hongjie
	 */
	public final class GuiDao extends Cell {
		
		private var _dir:int;
		
		public function GuiDao(width:int, height:int, dir:int) {
			super(width, height, 0xffc000);
			_dir = dir;
		}
		
	}

}
package model {
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class XianCao extends Cell {
		
		private var _dir:int;
		
		public function XianCao(width:int, height:int, dir:int) {
			super(width, height, 0x5b9bd5);
			_dir = dir
		}
		
		public function get dir():int {
			return _dir;
		}
		
		public function set dir(value:int):void {
			_dir = value;
		}
		
		public function get size():int {
			return _dir == Enum.H ? _h : _w;
		}
		
		public function set size(val:int):void {
			if (_dir == Enum.H) {
				setSize(_w, val);
			} else {
				setSize(val, _h);
			}
		}
	
	}

}
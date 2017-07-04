package model {
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class YuanJianManager {
		
		private static var _instace:YuanJianManager;
		
		public var itemArr:Vector.<YuanJian> = new Vector.<YuanJian>();
		
		public function YuanJianManager() {
		
		}
		
		public function removeByName(name:String):YuanJian {
			for (var i:int = 0; i < itemArr.length; i++) {
				if (itemArr[i].name == name) {
					return itemArr.splice(i, 1)[0];
				}
			}
			return null;
		}
		
		public function clear():void {
			for each (var y:YuanJian in itemArr) {
				if(y.parent)
					y.parent.removeChild(y);
			}
			itemArr.length = 0;
		}
		
		public function getYuanJian(name:String):YuanJian {
			for each (var y:YuanJian in itemArr) {
				if (y.name == name) return y;
			}
			return null;
		}
		
		public static function get instance():YuanJianManager {
			if (!YuanJianManager._instace) {
				YuanJianManager._instace = new YuanJianManager();
			}
			return YuanJianManager._instace;
		}
	
	}

}
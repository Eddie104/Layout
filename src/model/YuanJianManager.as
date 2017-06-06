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
		
		public static function get instance():YuanJianManager {
			if (!YuanJianManager._instace) {
				YuanJianManager._instace = new YuanJianManager();
			}
			return YuanJianManager._instace;
		}
	
	}

}
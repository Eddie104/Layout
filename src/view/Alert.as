package view {
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class Alert extends Sprite {
		
		private static var _instance:Alert;
		
		public function Alert() {
			super();
		}
		
		public function get instance():Alert {
			if (!_instance) {
				_instance = new Alert();
			}
			return _instance;
		}
	
	}

}
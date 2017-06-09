package view {
	
	import flash.display.Graphics;
	import flash.display.Sprite;
	
	/**
	 * ...
	 * @author 鸿杰
	 */
	public final class ScaleRect extends Sprite {
		
		private var _isEnabeld:Boolean = true;
		
		public function ScaleRect() {
			super();
			isEnabeld = true;
		}
		
		public function get isEnabeld():Boolean {
			return _isEnabeld;
		}
		
		public function set isEnabeld(value:Boolean):void {
			_isEnabeld = value;
			_drawMe();
		}
		
		private function _drawMe():void {
			const g:Graphics = this.graphics;
			g.clear();
			g.beginFill(_isEnabeld ? 0x00ff00 : 0xc9c9c9);
			g.drawRect(-5, -5, 10, 10);
			g.endFill();
		}
	
	}

}
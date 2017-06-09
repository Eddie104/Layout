package view {
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import model.YuanJian;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class DragingBitmap extends Bitmap {
		
		private var _yuanJian:YuanJian;
		
		public function DragingBitmap() {
			super();
		}
		
		public function get yuanJian():YuanJian {
			return _yuanJian;
		}
		
		public function set yuanJian(value:YuanJian):void {
			_yuanJian = value;
			if (this.bitmapData) this.bitmapData.dispose();
			this.bitmapData = new BitmapData(_yuanJian.reallyWidth, _yuanJian.reallyHeight, true, 0);
			this.bitmapData.draw(_yuanJian);
		}
		
		
	
	}

}
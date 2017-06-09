package view {
	import flash.events.Event;
	import model.Cell;
	import model.GuiDao;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class ShuXingGuiDao extends ShuXing {
		
		public function ShuXingGuiDao(width:int, height:int) {
			super(width, height, '轨道');
		}
		
		override public function setCurCell(cell:Cell):void {
			super.setCurCell(cell);
			if (guiDao.isJiaDe) {
				_xTF.mouseEnabled = false;
				_widthTF.mouseEnabled = false;
				_heightTF.mouseEnabled = false;
				
				_typeLabel.text = '虚拟轨道';
			} else {
				_typeLabel.text = '轨道';
			}
		}
		
		override protected function _onHeightChanged(e:Event):void {
			if (!guiDao.isJiaDe)
				super._onHeightChanged(e);
		}
		
		override protected function _onWidthChanged(e:Event):void {
			if (!guiDao.isJiaDe)
				super._onWidthChanged(e);
		}
		
		override protected function _onXChanged(e:Event):void {
			if (!guiDao.isJiaDe)
				super._onXChanged(e);
		}
		
		private function get guiDao():GuiDao {
			return this._curCell as GuiDao;
		}
	
	}

}
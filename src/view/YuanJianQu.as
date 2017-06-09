package view {
	import config.ConfigUtil;
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import model.YuanJian;
	import model.YuanJianManager;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class YuanJianQu extends Sprite {
		
		private var _yuanJianArr:Vector.<YuanJian> = new Vector.<YuanJian>();
		
		private var _w:int;
		
		private var _h:int;
		
		public function YuanJianQu(width:int, height:int) {
			super();
			_w = width;
			_h = height;
			
			const g:Graphics = this.graphics;
			g.lineStyle(1, 0xff0000);
			g.moveTo(0, 0);
			g.lineTo(width - 1, 0);
			g.lineTo(width - 1, height);
			g.lineTo(0, height);
			g.lineTo(0, 0);
			
			g.beginFill(0xff0000, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			ConfigUtil.instance.addEventListener(LayoutEvent.IMPORT_XML_OK, _onReset);
		}
		
		private function _onReset(e:LayoutEvent):void {
			this.removeChildren();
			_yuanJianArr.length = 0;
			
			var x:int = 0, y:int = 0, gap:int = 10, maxY:int = 0;
			var yuanJian:YuanJian;
			for (var i:int = 0; i < YuanJianManager.instance.itemArr.length; i++) {
				yuanJian = YuanJianManager.instance.itemArr[i];
				if (x + yuanJian.reallyWidth > _w) {
					x = 0;
					y = maxY + gap
				}
				yuanJian.x = x;
				yuanJian.y = y;
				yuanJian.addEventListener(MouseEvent.MOUSE_DOWN, _onStartDrag);
				addChild(yuanJian);
				x += yuanJian.reallyWidth + gap;
				maxY = yuanJian.reallyHeight + yuanJian.y > maxY ? yuanJian.reallyHeight + yuanJian.y : maxY;
			}
		}
		
		private function _onStartDrag(e:MouseEvent):void {
			const yuanJian:YuanJian = e.currentTarget as YuanJian;
			if (yuanJian.parent == this) {
				dispatchEvent(new LayoutEvent(LayoutEvent.START_TO_DTAG_YUAN_JIAN, null, yuanJian));
			}
		}
	
	}

}
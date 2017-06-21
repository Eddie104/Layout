package model {
	import events.LayoutEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class GuiDao extends Cell {
		
		private var _dir:int;
		
		private var _isJiaDe:Boolean;
		
		private var _yuanJianArr:Vector.<YuanJian> = new Vector.<YuanJian>();
		
		public function GuiDao(width:int, height:int, dir:int, jiaDe:Boolean) {
			super(width, height, jiaDe ? 0xff3600 : 0xffc000);
			_dir = dir;
			_isJiaDe = jiaDe;
		}
		
		public function get dir():int {
			return _dir;
		}
		
		public function set dir(value:int):void {
			_dir = value;
		}
		
		public function get isJiaDe():Boolean {
			return _isJiaDe;
		}
		
		public function addYuanJian(yuanJian:YuanJian, p:Point):Boolean {
			var insert:Boolean = false;
			for (var i:int = 0; i < _yuanJianArr.length; i++) {
				if (p.x < _yuanJianArr[i].x) {
					_yuanJianArr.splice(i, 0, yuanJian);
					insert = true;
					break;
				}
			}
			
			if (!insert) {
				_yuanJianArr.push(yuanJian);
			}
			// 根据拖动，自动算出offsetX
			const prevIndex:int = _yuanJianArr.indexOf(yuanJian) - 1;
			if (prevIndex > -1) {
				var offsetX:int = p.x - (_yuanJianArr[prevIndex].x + _yuanJianArr[prevIndex].reallyWidth);
				if (offsetX > 10) {
					yuanJian.offsetX = offsetX;
				} else {
					yuanJian.offsetX = 0;
				}
			}
			yuanJian.isOnGuiDao = true;
			yuanJian.guiDao = this;
			addChild(yuanJian);
			yuanJian.addEventListener(MouseEvent.CLICK, onYuanJianClicked);
			resetYuanJian(true);
			
			return true;
		}
		
		public function removeYuanJian(yuanJian:YuanJian, needReset:Boolean = true):void {
			for (var i:int = 0; i < _yuanJianArr.length; i++) {
				if (_yuanJianArr[i] == yuanJian) {
					_yuanJianArr.splice(i, 1);
					break;
				}
			}
			yuanJian.guiDao = null;
			if (yuanJian.parent == this)
				removeChild(yuanJian);
			yuanJian.removeEventListener(MouseEvent.CLICK, onYuanJianClicked);
			if (needReset)
				resetYuanJian();
		}
		
		override public function setSize(w:int, h:int = -1):void {
			super.setSize(w, h);
			resetYuanJian();
		}
		
		public function getPrevYuanJian(yuanJian:YuanJian):YuanJian {
			for (var i:int = 1; i < _yuanJianArr.length; i++) {
				if (_yuanJianArr[i] == yuanJian) {
					return _yuanJianArr[i - 1];
				}
			}
			return null;
		}
		
		public function resetYuanJian(removeOutRange:Boolean = false):void {
			if (_yuanJianArr.length > 0) {
				_yuanJianArr[0].x = _yuanJianArr[0].offsetX;
				_yuanJianArr[0].y = (_h - _yuanJianArr[0].reallyHeight) / 2;
				_resetYuanJianTopAndBottomYuanJian(_yuanJianArr[0]);
			}
			for (var i:int = 1; i < _yuanJianArr.length; i++) {
				_yuanJianArr[i].x = _yuanJianArr[i - 1].x + _yuanJianArr[i - 1].reallyWidth + _yuanJianArr[i].offsetX;
				_yuanJianArr[i].y = (_h - _yuanJianArr[i].reallyHeight) / 2;
				_resetYuanJianTopAndBottomYuanJian(_yuanJianArr[i]);
			}
			if (removeOutRange) {
				var yuanJian:YuanJian;
				for (i = _yuanJianArr.length - 1; i > -1; i--) {
					if (_yuanJianArr[i].x + _yuanJianArr[i].reallyWidth > _w) {
						yuanJian = _yuanJianArr[i];
						removeYuanJian(_yuanJianArr[i], false);
						dispatchEvent(new LayoutEvent(LayoutEvent.DELETE, null, yuanJian));
					}
				}
			}
		}
		
		private function _resetYuanJianTopAndBottomYuanJian(yuanJian:YuanJian):void {
			const topYuanJian:YuanJian = yuanJian.topYuanJian;
			if (topYuanJian) {
				topYuanJian.x = yuanJian.x - ((topYuanJian.reallyWidth - yuanJian.reallyWidth) >> 1);
				topYuanJian.y = yuanJian.y - topYuanJian.reallyHeight;
			}
			const bottomYuanJian:YuanJian = yuanJian.bottomYuanJian;
			if (bottomYuanJian) {
				bottomYuanJian.x = yuanJian.x - ((bottomYuanJian.reallyWidth - yuanJian.reallyWidth) >> 1);
				bottomYuanJian.y = yuanJian.y + yuanJian.reallyHeight;
			}
		}
		
		public function removeAllYuanJian():Vector.<YuanJian> {
			var yuanJian:YuanJian;
			for (var i:int = 0; i < _yuanJianArr.length; i++) {
				yuanJian = _yuanJianArr[i];
				yuanJian.guiDao = null;
				removeChild(yuanJian);
				yuanJian.removeEventListener(MouseEvent.CLICK, onYuanJianClicked);
			}
			var yuanJianArr:Vector.<YuanJian> = _yuanJianArr.slice();
			_yuanJianArr.length = 0;
			resetYuanJian();
			return yuanJianArr;
		}
		
		public function onYuanJianClicked(e:MouseEvent):void {
			const yuanJian:YuanJian = e.currentTarget as YuanJian;
			if (yuanJian.parent == this) {
				dispatchEvent(new LayoutEvent(LayoutEvent.SHOW_YUAN_JIAN_SHU_XING, null, yuanJian, e.ctrlKey));
				e.stopImmediatePropagation();
			}
		}
		
		override public function toXML():String {
			// <PATHWAY NAME="Path_0001" SIZE="460,10" START="20,700" END= "480,700" />
			return '<pathway virtual="' + this.isJiaDe + '" name="' + this.name + '" x="' + this.x + '" y="' + this.y + '" w="' + this.reallyWidth + '" h="' + this.reallyHeight + '" />';
		}
		
		public function yuanJianToXML():String {
			var s:String = '';
			for (var i:int = 0; i < _yuanJianArr.length; i++) {
				s += '\n\t\t' + _yuanJianArr[i].toXML();
			}
			return s;
		}
		
		public function initYuanJian(yuanJian:YuanJian, x:int, y:int):void {
			if (_yuanJianArr.length == 0) {
				yuanJian.offsetX = x;
			} else {
				yuanJian.offsetX = x - (_yuanJianArr[_yuanJianArr.length - 1].x + _yuanJianArr[_yuanJianArr.length - 1].reallyWidth);
			}
			yuanJian.x = x;
			yuanJian.y = y;
			_yuanJianArr.push(yuanJian);
			
			yuanJian.isOnGuiDao = true;
			yuanJian.guiDao = this;
			addChild(yuanJian);
			yuanJian.addEventListener(MouseEvent.CLICK, onYuanJianClicked);
		}
		
		public function addKaKou(p:Point):void {
			addYuanJian(new KaKou(20, _h + 20), p);
		}
	
	}

}
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
			//const newX:int = _yuanJianArr.length == 0 ? 0 : _yuanJianArr[_yuanJianArr.length - 1].x + _yuanJianArr[_yuanJianArr.length - 1].reallyWidth;
			//if (newX + yuanJian.reallyWidth > _w) return false
			//yuanJian.guiDao = this;
			//if (yuanJian.parent) yuanJian.parent.removeChild(yuanJian);
			//yuanJian.x = newX
			//yuanJian.y = (_h - yuanJian.reallyHeight) / 2;
			//this.addChild(yuanJian);
			//_yuanJianArr.push(yuanJian);
			//yuanJian.offsetX = 0;
			//yuanJian.addEventListener(MouseEvent.CLICK, _onYuanJianClicked);
			//return true;
			
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
			yuanJian.guiDao = this;
			addChild(yuanJian);
			yuanJian.addEventListener(MouseEvent.CLICK, _onYuanJianClicked);
			resetYuanJian();
			
			return true;
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
		
		public function resetYuanJian():void {
			if (_yuanJianArr.length > 0) {
				_yuanJianArr[0].x = _yuanJianArr[0].offsetX;
				_yuanJianArr[0].y = (_h - _yuanJianArr[0].reallyHeight) / 2;
			}
			for (var i:int = 1; i < _yuanJianArr.length; i++) {
				_yuanJianArr[i].x = _yuanJianArr[i - 1].x + _yuanJianArr[i - 1].reallyWidth + _yuanJianArr[i].offsetX;
				_yuanJianArr[i].y = (_h - _yuanJianArr[i].reallyHeight) / 2;
			}
		}
		
		private function _onYuanJianClicked(e:MouseEvent):void {
			const yuanJian:YuanJian = e.currentTarget as YuanJian;
			if (yuanJian.parent == this) {
				dispatchEvent(new LayoutEvent(LayoutEvent.SHOW_YUAN_JIAN_SHU_XING, null, yuanJian, e.ctrlKey));
				e.stopImmediatePropagation();
			}
		}
	
	}

}
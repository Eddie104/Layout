package model {
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import view.YuanJianTip;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class YuanJian extends Cell {
		
		protected var _offsetX:Number;
		
		protected var _guiDao:GuiDao;
		
		public var yuanJianX:int;
		
		public var yuanJianY:int;
		
		protected var _topYuanJian:YuanJian;
		
		protected var _bottomYuanJian:YuanJian;
		
		protected var _isOnGuiDao:Boolean;
		
		protected var _isKaKou:Boolean;
		
		protected var _marginTopToXianCao:int;
		
		protected var _marginBottomToXianCao:int;
		
		private var _code:String;
		
		public function YuanJian(width:int, height:int, color:int, name:String, code:String) {
			super(width, height, color);
			this._code = code;
			this.name = name;
			
			this.addEventListener(MouseEvent.MOUSE_OVER, _onMouseOver);
			this.addEventListener(MouseEvent.MOUSE_OUT, _onMouseOut);
		}
		
		private function _onMouseOver(e:MouseEvent):void {
			if (!(this.parent is GuiDao)) return;
			if (e.target == this) {
				const tip:YuanJianTip = YuanJianTip.instance;
				tip.setYuanJian(this);
				const p:Point = this.localToGlobal(new Point(e.localX, e.localY));
				tip.x = p.x;
				tip.y = p.y;
				Main.mainScene.addChild(tip);
			}
		}
		
		private function _onMouseOut(e:MouseEvent):void {
			const tip:YuanJianTip = YuanJianTip.instance;
			if (tip.parent) {
				tip.parent.removeChild(tip);
			}
		}
		
		public function get offsetX():Number {
			return _offsetX;
		}
		
		public function set offsetX(value:Number):void {
			_offsetX = value;
			if (_guiDao)
				_guiDao.resetYuanJian();
		}
		
		public function get guiDao():GuiDao {
			return _guiDao;
		}
		
		public function set guiDao(value:GuiDao):void {
			_guiDao = value;
		}
		
		public function get topYuanJian():YuanJian {
			return _topYuanJian;
		}
		
		public function set topYuanJian(value:YuanJian):void {
			_topYuanJian = value;
			if (value) {
				if (value.parent != this.parent) {
					value.x = this.x - ((value.reallyWidth - this.reallyWidth) >> 1);
					value.y = this.y - value.reallyHeight;
					this.parent.addChild(value);
					value.guiDao = this.guiDao;
					value.isOnGuiDao = false;
					value.addEventListener(MouseEvent.CLICK, this.guiDao.onYuanJianClicked);
				}
				if (value.bottomYuanJian != this) {
					value.bottomYuanJian = this;
				}
			}
		}
		
		public function get bottomYuanJian():YuanJian {
			return _bottomYuanJian;
		}
		
		public function set bottomYuanJian(value:YuanJian):void {
			_bottomYuanJian = value;
			if (value) {
				if (value.parent != this.parent) {
					value.x = this.x - ((value.reallyWidth - this.reallyWidth) >> 1);
					value.y = this.y + this.reallyHeight;
					this.parent.addChildAt(value, this.parent.getChildIndex(this));
					value.guiDao = this.guiDao;
					value.isOnGuiDao = false;
					value.addEventListener(MouseEvent.CLICK, this.guiDao.onYuanJianClicked);
				}
				if (value.topYuanJian != this) {
					value.topYuanJian = this;
				}
			}
		}
		
		public function get isOnGuiDao():Boolean {
			return _isOnGuiDao;
		}
		
		public function set isOnGuiDao(value:Boolean):void {
			_isOnGuiDao = value;
		}
		
		public function get isKaKou():Boolean {
			return _isKaKou;
		}
		
		public function get marginTopToXianCao():int {
			return _marginTopToXianCao;
		}
		
		public function set marginTopToXianCao(value:int):void {
			_marginTopToXianCao = value;
		}
		
		public function get marginBottomToXianCao():int {
			return _marginBottomToXianCao;
		}
		
		public function set marginBottomToXianCao(value:int):void {
			_marginBottomToXianCao = value;
		}
		
		public function get code():String {
			return _code;
		}
		
		override public function toXML():String {
			//if (this.topYuanJian && !this.bottomYuanJian) {
			//return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '">\n\t\t\t<topItem name="' + topYuanJian.name + '" />\n\t\t</item>';
			//} else if (!this.topYuanJian && this.bottomYuanJian) {
			//return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '">\n\t\t\t<bottomItem name="' + bottomYuanJian.name + '" />\n\t\t</item>';
			//} else if (this.topYuanJian && this.bottomYuanJian) {
			//return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '">\n\t\t\t<topItem name="' + topYuanJian.name + '" />\n\t\t\t<bottomItem name="' + bottomYuanJian.name + '" />\n\t\t</item>';
			//}
			//return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" />';
			
			if (this.topYuanJian && !this.bottomYuanJian) {
				return '<item code="' + this.code + '" name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" topItem="' + topYuanJian.name + '" />';
			} else if (!this.topYuanJian && this.bottomYuanJian) {
				return '<item code="' + this.code + '" name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" bottomItem="' + bottomYuanJian.name + '" />';
			} else if (this.topYuanJian && this.bottomYuanJian) {
				return '<item code="' + this.code + '" name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" topItem="' + topYuanJian.name + '" bottomItem="' + bottomYuanJian.name + '" />';
			}
			return '<item code="' + this.code + '" name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" />';
		}
		
		override public function quZheng():void {
			this._offsetX = int(this._offsetX);
			super.quZheng();
		}
	
	}

}
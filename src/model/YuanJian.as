package model {
	import flash.events.MouseEvent;
	
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
		
		public function YuanJian(width:int, height:int, color:int, name:String) {
			super(width, height, color);
			this.name = name;
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
				return '<item name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" topItem="' + topYuanJian.name + '" />';
			} else if (!this.topYuanJian && this.bottomYuanJian) {
				return '<item name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" bottomItem="' + bottomYuanJian.name + '" />';
			} else if (this.topYuanJian && this.bottomYuanJian) {
				return '<item name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" topItem="' + topYuanJian.name + '" bottomItem="' + bottomYuanJian.name + '" />';
			}
			return '<item name="' + this.name + '" color="0x' + _bgColor.toString(16) + '" w="' + _w + '" h="' + _h + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" />';
		}
		
		override public function quZheng():void {
			this._offsetX = int(this._offsetX);
			super.quZheng();
		}
	
	}

}
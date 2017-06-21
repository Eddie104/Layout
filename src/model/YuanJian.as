package model {
	import flash.events.MouseEvent;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class YuanJian extends Cell {
		
		protected var _offsetX:int;
		
		protected var _guiDao:GuiDao;
		
		public var yuanJianX:int;
		
		public var yuanJianY:int;
		
		protected var _topYuanJian:YuanJian;
		
		protected var _bottomYuanJian:YuanJian;
		
		protected var _isOnGuiDao:Boolean;
		
		protected var _isKaKou:Boolean;
		
		public function YuanJian(width:int, height:int, color:int, name:String) {
			super(width, height, color);
			this.name = name;
		}
		
		public function get offsetX():int {
			return _offsetX;
		}
		
		public function set offsetX(value:int):void {
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
				return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" topItem="' + topYuanJian.name + '" />';
			} else if (!this.topYuanJian && this.bottomYuanJian) {
				return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" bottomItem="' + bottomYuanJian.name + '" />';
			} else if (this.topYuanJian && this.bottomYuanJian) {
				return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" topItem="' + topYuanJian.name + '" bottomItem="' + bottomYuanJian.name + '" />';
			}
			return '<item name="' + this.name + '" pathway="' + this.guiDao.name + '" x="' + this.x + '" y="' + this.y + '" />';
		}
	
	}

}
package view {
	import config.ConfigUtil;
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import model.Cell;
	import model.GuiDao;
	import model.KaKou;
	import model.XianCao;
	import model.YuanJian;
	import model.YuanJianManager;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class BuJuQu extends Sprite {
		
		public static var containerScale:Number = 1;
		
		//public var selectedCellArr:Vector.<Cell> = new Vector.<Cell>();
		private var _selectedCell:Cell;
		
		private var _guiDaoContainer:Sprite;
		
		private var _xianCaoContainer:Sprite;
		
		private var _container:Sprite;
		
		private var _w:int;
		
		private var _h:int;
		
		private var _viewWidth:int;
		
		private var _viewHeight:int;
		
		public function BuJuQu(width:int, height:int) {
			super();
			_w = width;
			_h = height;
			
			_viewWidth = width;
			_viewHeight = height;
			
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
			
			_container = new Sprite();
			const mask:Shape = new Shape();
			mask.graphics.beginFill(0, 0);
			mask.graphics.drawRect(0, 0, _w, _h);
			mask.graphics.endFill();
			addChild(mask);
			_container.mask = mask;
			addChild(_container);
			
			_xianCaoContainer = new Sprite();
			_container.addChild(_xianCaoContainer);
			_guiDaoContainer = new Sprite();
			_container.addChild(_guiDaoContainer);
			
			ConfigUtil.instance.addEventListener(LayoutEvent.IMPORT_XML_OK, _onReset);
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMoved);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			this.addEventListener(MouseEvent.CLICK, _onBuJuClicked);
			
			ScaleLine.instance.addEventListener(LayoutEvent.COPY, _onCopy);
			ScaleLine.instance.addEventListener(LayoutEvent.DELETE, _onDelete);
		}
		
		public function addGuiDao(isJiaDe:Boolean, w:int = 50, h:int = 40, x:int = 0, y:int = 0, name:String = null):void {
			x = x / _container.scaleX;
			y = y / _container.scaleY;
			var guiDao:GuiDao = new GuiDao(isJiaDe ? _w : w, isJiaDe ? 10 : h, Enum.H, isJiaDe);
			guiDao.x = isJiaDe ? 0 : x;
			guiDao.y = y;
			if (name) {
				guiDao.name = name;
				_guiDaoContainer.addChildAt(guiDao, int(name) - 1);
			} else {
				_guiDaoContainer.addChild(guiDao);
				guiDao.name = _guiDaoContainer.numChildren.toString();
			}
			guiDao.addEventListener(MouseEvent.CLICK, _onCellClicked);
			guiDao.addEventListener(LayoutEvent.SHOW_YUAN_JIAN_SHU_XING, _onShowYuanJianShuXing);
			guiDao.addEventListener(LayoutEvent.DELETE, _onDeleteYuanJian);
			
			ScaleLine.instance.parentCell = guiDao;
			
			//_clearSelectedCell();
			//selectedCellArr.push(guiDao);
			if (_selectedCell) {
				_selectedCell.isSelected = false;
			}
			_selectedCell = guiDao;
			guiDao.isSelected = true;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.ADD_GUI_DAO));
		}
		
		public function addXianCao(w:int = 200, h:int = 80, x:int = 0, y:int = 0, name:String = null):void {
			x = x / _container.scaleX;
			y = y / _container.scaleY;
			var xianCao:XianCao = new XianCao(w, h, Enum.H);
			xianCao.x = x;
			xianCao.y = y;
			if (name) {
				xianCao.name = name;
				_xianCaoContainer.addChildAt(xianCao, int(name) - 1);
			} else {
				_xianCaoContainer.addChild(xianCao);
				xianCao.name = _xianCaoContainer.numChildren.toString();
			}
			xianCao.addEventListener(MouseEvent.CLICK, _onCellClicked);
			
			ScaleLine.instance.parentCell = xianCao;
			
			//_clearSelectedCell();
			//selectedCellArr.push(xianCao);
			if (_selectedCell) {
				_selectedCell.isSelected = false;
			}
			_selectedCell = xianCao;
			xianCao.isSelected = true;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.ADD_XIAN_CAO));
		}
		
		public function exportXianCao():String {
			var s:String = '';
			var xianCao:XianCao;
			for (var i:int = 0; i < _xianCaoContainer.numChildren; i++) {
				xianCao = _xianCaoContainer.getChildAt(i) as XianCao;
				s += (s == '' ? '\t\t' : '\n\t\t') + xianCao.toXML();
			}
			return s;
		}
		
		public function exportGuiDao():String {
			var s:String = '';
			var guidao:GuiDao;
			for (var i:int = 0; i < _guiDaoContainer.numChildren; i++) {
				guidao = _guiDaoContainer.getChildAt(i) as GuiDao;
				s += '\n\t\t' + guidao.toXML();
			}
			return s;
		}
		
		public function exportYuanJian():String {
			var s:String = '';
			var guidao:GuiDao;
			for (var i:int = 0; i < _guiDaoContainer.numChildren; i++) {
				guidao = _guiDaoContainer.getChildAt(i) as GuiDao;
				s += guidao.yuanJianToXML();
			}
			return s;
		}
		
		public function initLayout(xml:XML, layoutXML:XML):void {
			var guiDao:GuiDao, yuanJian:YuanJian;
			for each (var item:* in layoutXML.items.item) {
				for (var i:int = 0; i < _guiDaoContainer.numChildren; i++) {
					guiDao = _guiDaoContainer.getChildAt(i) as GuiDao;
					if (guiDao.name == item.@pathway) {
						if (item.@name == 'kaKou'){
							yuanJian = new KaKou(item.@w, item.@h);
						} else {
							yuanJian = YuanJianManager.instance.getYuanJian(item.@name);
						}
						
						guiDao.initYuanJian(yuanJian, item.@x, item.@y);
						if (item.@topItem) {
							yuanJian.topYuanJian = YuanJianManager.instance.getYuanJian(item.@topItem);
						}
						if (item.@bottomItem) {
							yuanJian.bottomYuanJian = YuanJianManager.instance.getYuanJian(item.@bottomItem);
						}
						break;
					}
				}
			}
		}
		
		private function _onDeleteYuanJian(e:LayoutEvent):void {
			if (e.yuanJian == ScaleLine.instance.parentCell) {
				ScaleLine.instance.parentCell = null;
				_selectedCell = null;
			}
			dispatchEvent(new LayoutEvent(LayoutEvent.RESET_YUAN_JIAN, null, e.yuanJian));
		}
		
		private function _onDelete(e:LayoutEvent):void {
			if (_selectedCell) {
				if (_selectedCell is GuiDao) {
					const guiDao:GuiDao = _selectedCell as GuiDao;
					_guiDaoContainer.removeChild(guiDao);
					guiDao.removeEventListener(MouseEvent.CLICK, _onCellClicked);
					guiDao.removeEventListener(LayoutEvent.SHOW_YUAN_JIAN_SHU_XING, _onShowYuanJianShuXing);
					guiDao.removeEventListener(LayoutEvent.DELETE, _onDeleteYuanJian);
					
					const yuanJianArr:Vector.<YuanJian> = guiDao.removeAllYuanJian();
					for (var i:int = 0; i < yuanJianArr.length; i++) {
						guiDao.removeYuanJian(yuanJianArr[i]);
						dispatchEvent(new LayoutEvent(LayoutEvent.RESET_YUAN_JIAN, null, yuanJianArr[i]));
					}
				} else if (_selectedCell is XianCao) {
					_xianCaoContainer.removeChild(_selectedCell);
					_selectedCell.removeEventListener(MouseEvent.CLICK, _onCellClicked);
				} else if (_selectedCell is YuanJian) {
					(_selectedCell.parent as GuiDao).removeYuanJian(_selectedCell as YuanJian);
					dispatchEvent(new LayoutEvent(LayoutEvent.RESET_YUAN_JIAN, null, _selectedCell as YuanJian));
				}
				ScaleLine.instance.parentCell = null;
				_selectedCell = null;
			}
		}
		
		private function _onCopy(e:LayoutEvent):void {
			if (_selectedCell) {
				if (_selectedCell is GuiDao) {
					addGuiDao(false, _selectedCell.reallyWidth, _selectedCell.reallyHeight, _selectedCell.x + 10, _selectedCell.y + 10);
				} else if (_selectedCell is XianCao) {
					addXianCao(_selectedCell.reallyWidth, _selectedCell.reallyHeight, _selectedCell.x + 10, _selectedCell.y + 10);
				}
			}
		}
		
		private function _onReset(evt:LayoutEvent):void {
			_container.scaleX = 1;
			_container.scaleY = 1;
			containerScale = 1;
			for (var i:int = 0; i < _xianCaoContainer.numChildren; i++ ){
				_xianCaoContainer.getChildAt(i).removeEventListener(MouseEvent.CLICK, _onCellClicked);
			}
			this._xianCaoContainer.removeChildren();
			for (i = 0; i < _guiDaoContainer.numChildren; i++ ){
				_guiDaoContainer.getChildAt(i).removeEventListener(MouseEvent.CLICK, _onCellClicked);
				_guiDaoContainer.getChildAt(i).removeEventListener(LayoutEvent.SHOW_YUAN_JIAN_SHU_XING, _onShowYuanJianShuXing);
				_guiDaoContainer.getChildAt(i).removeEventListener(LayoutEvent.DELETE, _onDeleteYuanJian);
			}
			_guiDaoContainer.removeChildren();
			
			var a:Array = evt.xml.layout.@size.split(',');
			_w = int(a[0]);
			_h = int(a[1]);
			const g:Graphics = _container.graphics;
			g.clear();
			g.beginFill(0x00f215, .6);
			g.drawRect(0, 0, _w, _h);
			g.endFill();
			
			const layoutXML:XML = evt.layoutXML;
			if (layoutXML) {
				for each (var item:* in layoutXML.layout.trunking) {
					this.addXianCao(item.@w, item.@h, item.@x, item.@y, item.@name);
				}
				for each (item in layoutXML.layout.pathway) {
					this.addGuiDao(item.@virtual == 'true', item.@w, item.@h, item.@x, item.@y, item.@name);
				}
			} else {
				this.addXianCao(_w, 20);
				this.addXianCao(20, _h, _w - 20);
				this.addXianCao(_w, 20, 0, _h - 20);
				this.addXianCao(20, _h);
			}
			
			var scale:Number = _viewWidth / _w;
			var h:Number = _h * scale;
			if (h > _viewHeight) {
				scale = _viewHeight / _h;
			}
			_container.scaleX = scale;
			_container.scaleY = scale;
			containerScale = scale;
		}
		
		private function _onShowYuanJianShuXing(e:LayoutEvent):void {
			cellClicked(e.yuanJian, e.isCtrlKey);
		}
		
		private function _onCellClicked(e:MouseEvent):void {
			const cell:Cell = e.currentTarget as Cell;
			cellClicked(cell, e.ctrlKey);
			e.stopImmediatePropagation();
		}
		
		private function cellClicked(cell:Cell, isCtrlKey:Boolean):void {
			//if (cell.isSelected) {
			//if (!isCtrlKey) {
			//_clearSelectedCell();
			//cell.isSelected = true;
			//selectedCellArr.push(cell);
			//} else {
			//cell.isSelected = false;
			//for (var i:int = 0; i < this.selectedCellArr.length; i++) {
			//if (this.selectedCellArr[i] == cell) {
			//this.selectedCellArr.splice(i, 1);
			//}
			//}
			//}
			//} else {
			//if (!isCtrlKey) {
			//_clearSelectedCell();
			//}
			//cell.isSelected = true;
			//selectedCellArr.push(cell);
			//}
			if (_selectedCell) {
				if (_selectedCell == cell) return;
				_selectedCell.isSelected = false;
			}
			_selectedCell = cell;
			_selectedCell.isSelected = true;
			ScaleLine.instance.parentCell = _selectedCell;
			
			this.dispatchEvent(new LayoutEvent(LayoutEvent.SELECTED_ARR_CHANGED));
		}
		
		//private function _clearSelectedCell():void {
		//for (var i:int = 0; i < this.selectedCellArr.length; i++) {
		//this.selectedCellArr[i].isSelected = false;
		//}
		//this.selectedCellArr.length = 0;
		//}
		
		private function _onMouseWheel(evt:MouseEvent):void {
			if (evt.delta < 0) {
				//向下滚动
				if (_container.scaleX > .2) {
					_container.scaleX -= .05;
					_container.scaleY -= .05;
					containerScale = _container.scaleX;
				}
			} else {
				if (_container.scaleX < 1) {
					_container.scaleX += .05;
					_container.scaleY += .05;
					if (_container.scaleX > 1) {
						_container.scaleX = 1;
					}
					if (_container.scaleY > 1) {
						_container.scaleY = 1;
					}
					containerScale = _container.scaleX;
				}
			}
		}
		
		private function _onMouseUp(evt:MouseEvent):void {
			ScaleLine.instance.mouseUped();
		}
		
		private function _onMouseMoved(evt:MouseEvent):void {
			if (evt.buttonDown) {
				ScaleLine.instance.mouseMoved(evt.stageX, evt.stageY);
			}
		}
		
		private function _onBuJuClicked(e:MouseEvent):void {
			ScaleLine.instance.parentCell = null;
			if (_selectedCell) {
				_selectedCell.isSelected = false;
				_selectedCell = null;
			}
		}
		
		public function get selectedCell():Cell {
			return _selectedCell;
		}
	}

}
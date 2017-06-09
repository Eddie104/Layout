package view {
	import config.ConfigUtil;
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.system.System;
	import model.Cell;
	import model.CopyCellData;
	import model.GuiDao;
	import model.XianCao;
	import model.YuanJian;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class BuJuQu extends Sprite {
		
		//public var selectedCellArr:Vector.<Cell> = new Vector.<Cell>();
		private var _selectedCell:Cell;
		
		private var _guiDaoContainer:Sprite;
		
		private var _xianCaoContainer:Sprite;
		
		private var _yuanJianContainer:Sprite;
		
		private var _container:Sprite;
		
		private var _w:int;
		
		private var _h:int;
		
		private var _copyCellData:CopyCellData;
		
		public function BuJuQu(width:int, height:int) {
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
			_yuanJianContainer = new Sprite();
			_container.addChild(_yuanJianContainer);
			
			ConfigUtil.instance.addEventListener(LayoutEvent.IMPORT_XML_OK, _onReset);
			
			this.addEventListener(MouseEvent.MOUSE_WHEEL, _onMouseWheel);
			
			this.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMoved);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			this.addEventListener(MouseEvent.CLICK, _onBuJuClicked);
			
			_copyCellData = new CopyCellData();
		}
		
		public function addGuiDao(isJiaDe:Boolean, w:int = 50, h:int = 40, x:int = 0, y:int = 0):void {
			var guiDao:GuiDao = new GuiDao(isJiaDe ? _w : w, isJiaDe ? 10 : h, Enum.H, isJiaDe);
			guiDao.x = x;
			guiDao.y = y;
			_guiDaoContainer.addChild(guiDao);
			guiDao.addEventListener(MouseEvent.CLICK, _onCellClicked);
			guiDao.addEventListener(LayoutEvent.SHOW_YUAN_JIAN_SHU_XING, _onShowYuanJianShuXing);
			
			ScaleLine.instance.parentCell = guiDao;
			
			//_clearSelectedCell();
			//selectedCellArr.push(guiDao);
			_selectedCell = guiDao;
			guiDao.isSelected = true;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.ADD_GUI_DAO));
		}
		
		public function addXianCao(w:int = 100, h:int = 20, x:int = 0, y:int = 0):void {
			var xianCao:XianCao = new XianCao(w, h, Enum.H);
			xianCao.x = x;
			xianCao.y = y;
			_xianCaoContainer.addChild(xianCao);
			xianCao.addEventListener(MouseEvent.CLICK, _onCellClicked);
			
			ScaleLine.instance.parentCell = xianCao;
			
			//_clearSelectedCell();
			//selectedCellArr.push(xianCao);
			_selectedCell = xianCao;
			xianCao.isSelected = true;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.ADD_XIAN_CAO));
		}
		
		public function copyCell():void {
			if (_selectedCell){
				if (_selectedCell is GuiDao || _selectedCell is XianCao){
					_copyCellData._isGuiDao = _selectedCell is GuiDao;
					_copyCellData.w = _selectedCell.reallyWidth;
					_copyCellData.h = _selectedCell.reallyHeight;
					_copyCellData.x = _selectedCell.x;
					_copyCellData.y = _selectedCell.y;
				}
			}
		}
		
		public function pasteCell():void {
			if (_copyCellData.w > 0) {
				if (_copyCellData._isGuiDao){
					addGuiDao(false, _copyCellData.w, _copyCellData.h, _copyCellData.x + 10, _copyCellData.y + 10);
				} else {
					addXianCao(_copyCellData.w, _copyCellData.h, _copyCellData.x + 10, _copyCellData.y + 10);
				}
			}
		}
		
		private function _onReset(evt:LayoutEvent):void {
			var a:Array = evt.xml.layout.@size.split(',');
			_w = int(a[0]);
			_h = int(a[1]);
			const g:Graphics = _container.graphics;
			g.clear();
			g.beginFill(0x00f215, .6);
			g.drawRect(0, 0, _w, _h);
			g.endFill();
		
			// 轨道
			//evt.xml.layout.pathway
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
					_container.scaleX -= .1;
					_container.scaleY -= .1;
				}
			} else {
				if (_container.scaleX < 1) {
					_container.scaleX += .1;
					_container.scaleY += .1;
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
			_selectedCell = null;
		}
		
		public function get selectedCell():Cell {
			return _selectedCell;
		}
	}

}
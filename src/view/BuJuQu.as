package view {
	import config.ConfigUtil;
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	import model.Cell;
	import model.GuiDao;
	import model.XianCao;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class BuJuQu extends Sprite {
		
		private var _xianCaoArr:Vector.<XianCao> = new Vector.<XianCao>();
		
		private var _guiDaoArr:Vector.<GuiDao> = new Vector.<GuiDao>();
		
		public var selectedCellArr:Vector.<Cell> = new Vector.<Cell>();
		
		private var _guiDaoContainer:Sprite;
		
		private var _xianCaoContainer:Sprite;
		
		private var _yuanJianContainer:Sprite;
		
		private var _container:Sprite;
		
		private var _w:int;
		
		private var _h:int;
		
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
		}
		
		public function addGuiDao():void {
			var guiDao:GuiDao = new GuiDao(50, 50, Enum.H);
			_guiDaoContainer.addChild(guiDao);
			_guiDaoArr.push(guiDao);
			guiDao.addEventListener(MouseEvent.CLICK, _onCellClicked);
			
			_clearSelectedCell();
			selectedCellArr.push(guiDao);
			guiDao.isSelected = true;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.ADD_GUI_DAO));
		}
		
		public function addXianCao():void {
			var xianCao:XianCao = new XianCao(50, 50);
			_xianCaoContainer.addChild(xianCao);
			_xianCaoArr.push(xianCao);
			xianCao.addEventListener(MouseEvent.CLICK, _onCellClicked);
			
			_clearSelectedCell();
			selectedCellArr.push(xianCao);
			xianCao.isSelected = true;
			this.dispatchEvent(new LayoutEvent(LayoutEvent.ADD_XIAN_CAO));
		}
		
		private function _onReset(evt:LayoutEvent):void {
			var a:Array = evt.xml.layout.@size.split(',');
			const g:Graphics = _container.graphics;
			g.clear();
			g.beginFill(0x00f215, .6);
			g.drawRect(0, 0, int(a[0]), int(a[1]));
			g.endFill();
		
			// 轨道
			//evt.xml.layout.pathway
		}
		
		private function _onCellClicked(e:MouseEvent):void {
			const cell:Cell = e.currentTarget as Cell;
			if (cell.isSelected) {
				if (!e.ctrlKey) {
					_clearSelectedCell();
					cell.isSelected = true;
					selectedCellArr.push(cell);
				} else {
					cell.isSelected = false;
					for (var i:int = 0; i < this.selectedCellArr.length; i++) {
						if (this.selectedCellArr[i] == cell) {
							this.selectedCellArr.splice(i, 1);
						}
					}
				}
			} else {
				cell.isSelected = true;
				if (!e.ctrlKey) {
					_clearSelectedCell();
				}
				selectedCellArr.push(cell);
			}
			this.dispatchEvent(new LayoutEvent(LayoutEvent.SELECTED_ARR_CHANGED));
		}
		
		private function _clearSelectedCell():void {
			for (var i:int = 0; i < this.selectedCellArr.length; i++) {
				this.selectedCellArr[i].isSelected = false;
			}
			this.selectedCellArr.length = 0;
		}
		
		private function _onMouseWheel(evt:MouseEvent):void {
			if (evt.delta < 0) {
				//向下滚动
				_container.scaleX -= .1;
				_container.scaleY -= .1;
			} else {
				if (_container.scaleX < 1) {
					_container.scaleX += .1;
					_container.scaleY += .1;
				}
			}
		}
	}

}
package view {
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import model.Cell;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class ShuXingQu extends Sprite {
		
		private var _buJuQu:BuJuQu;
		
		private var _curCell:Cell;
		
		private var _xTF:TextField;
		
		private var _yTF:TextField;
		
		private var _widthTF:TextField;
		
		private var _heightTF:TextField;
		
		public function ShuXingQu(width:int, height:int, buJuQu:BuJuQu) {
			super();
			
			const g:Graphics = this.graphics;
			g.beginFill(0, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			var label:TextField = new TextField();
			label.mouseEnabled = false;
			label.text = '坐标X:';
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			var border:Shape = _drawInputBorder(50, 18);
			border.x = 40;
			border.y = label.y;
			addChild(border);
			_xTF = new TextField();
			_xTF.type = TextFieldType.INPUT;
			_xTF.text = '0';
			_xTF.width = 50;
			_xTF.height = 18;
			_xTF.restrict = '0-9';
			_xTF.x = 40;
			_xTF.y = label.y;
			_xTF.addEventListener(Event.CHANGE, _onXChanged);
			addChild(_xTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '坐标Y:';
			label.x = 100;
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			border = _drawInputBorder(50, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_yTF = new TextField();
			_yTF.type = TextFieldType.INPUT;
			_yTF.text = '0';
			_yTF.width = 50;
			_yTF.height = 18;
			_yTF.restrict = '0-9';
			_yTF.x = 40 + label.x;
			_yTF.y = label.y;
			_yTF.addEventListener(Event.CHANGE, _onYChanged);
			addChild(_yTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '宽度:';
			label.x = 200;
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			border = _drawInputBorder(50, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_widthTF = new TextField();
			_widthTF.type = TextFieldType.INPUT;
			_widthTF.text = '0';
			_widthTF.width = 50;
			_widthTF.height = 18;
			_widthTF.restrict = '0-9';
			_widthTF.x = 40 + label.x;
			_widthTF.y = label.y;
			_widthTF.addEventListener(Event.CHANGE, _onWidthChanged);
			addChild(_widthTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '高度:';
			label.x = 300;
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			border = _drawInputBorder(50, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_heightTF = new TextField();
			_heightTF.type = TextFieldType.INPUT;
			_heightTF.text = '0';
			_heightTF.width = 50;
			_heightTF.height = 18;
			_heightTF.restrict = '0-9';
			_heightTF.x = 40 + label.x;
			_heightTF.y = label.y;
			_heightTF.addEventListener(Event.CHANGE, _onHeightChanged);
			addChild(_heightTF);
			
			this._buJuQu = buJuQu;
			_buJuQu.addEventListener(LayoutEvent.ADD_GUI_DAO, _onAddGuidao);
			_buJuQu.addEventListener(LayoutEvent.ADD_XIAN_CAO, _onAddXianCao);
			_buJuQu.addEventListener(LayoutEvent.SELECTED_ARR_CHANGED, _onSelectedArrChanged);
		}
		
		private function _onSelectedArrChanged(e:LayoutEvent):void {
			if (_buJuQu.selectedCellArr.length == 1) {
				setCurCell(_buJuQu.selectedCellArr[0]);
			} else {
				setCurCell(null);
			}
		}
		
		private function _onHeightChanged(e:Event):void {
			if (_curCell) {
				_curCell.setSize(_curCell.reallyWidth, int(_heightTF.text));
			}
		}
		
		private function _onWidthChanged(e:Event):void {
			if (_curCell) {
				_curCell.setSize(int(_widthTF.text), _curCell.reallyHeight);
			}
		}
		
		private function _onYChanged(e:Event):void {
			if (_curCell) {
				_curCell.y = int(_yTF.text);
			}
		}
		
		private function _onXChanged(e:Event):void {
			if (this._curCell) {
				_curCell.x = int(_xTF.text);
			}
		}
		
		private function _onAddXianCao(e:LayoutEvent):void {
			setCurCell(_buJuQu.selectedCellArr[0]);
		}
		
		private function _onAddGuidao(e:LayoutEvent):void {
			setCurCell(_buJuQu.selectedCellArr[0]);
		}
		
		private function setCurCell(cell:Cell):void {
			this._curCell = cell;
			if (cell) {
				this._xTF.text = cell.x.toString();
				_yTF.text = cell.y.toString();
				_widthTF.text = cell.reallyWidth.toString();
				_heightTF.text = cell.reallyHeight.toString();
			}
		}
		
		private function _drawInputBorder(w:int, h:int):Shape {
			var s:Shape = new Shape();
			const g:Graphics = s.graphics;
			g.lineStyle(1, 0xff0000);
			g.moveTo(0, 0);
			g.lineTo(w - 1, 0);
			g.lineTo(w - 1, h);
			g.lineTo(0, h);
			g.lineTo(0, 0);
			return s;
		}
	
	}

}
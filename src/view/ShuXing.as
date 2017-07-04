package view {
	import flash.display.Graphics;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import model.Cell;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class ShuXing extends Sprite {
		
		protected var _typeLabel:TextField;
		
		protected var _curCell:Cell;
		
		protected var _xTF:TextField;
		
		protected var _yTF:TextField;
		
		protected var _widthTF:TextField;
		
		protected var _heightTF:TextField;
		
		public function ShuXing(width:int, height:int, type:String) {
			super();
			_typeLabel = new TextField();
			_typeLabel.text = type;
			_typeLabel.mouseEnabled = false;
			addChild(_typeLabel);
			
			_init(width, height);
		}
		
		protected function _init(width:int, height:int):void {
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
			label.text = '长度:';
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
		}
		
		public function setCurCell(cell:Cell):void {
			_curCell = cell;
			if (cell){
				this._xTF.text = cell.x.toString();
				_yTF.text = cell.y.toString();
				_widthTF.text = cell.reallyWidth.toString();
				_heightTF.text = cell.reallyHeight.toString();
				
				_xTF.mouseEnabled = true;
				_yTF.mouseEnabled = true;
				_widthTF.mouseEnabled = true;
				_heightTF.mouseEnabled = true;
			}
		}
		
		protected function _drawInputBorder(w:int, h:int):Shape {
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
		
		protected function _onHeightChanged(e:Event):void {
			if (_curCell) {
				_curCell.setSize(_curCell.reallyWidth, int(_heightTF.text));
				if (ScaleLine.instance.parentCell == _curCell){
					ScaleLine.instance.resetRect();
				}
			}
		}
		
		protected function _onWidthChanged(e:Event):void {
			if (_curCell) {
				_curCell.setSize(int(_widthTF.text), _curCell.reallyHeight);
				if (ScaleLine.instance.parentCell == _curCell){
					ScaleLine.instance.resetRect();
				}
			}
		}
		
		protected function _onYChanged(e:Event):void {
			if (_curCell) {
				_curCell.y = int(_yTF.text);
				if (ScaleLine.instance.parentCell == _curCell){
					ScaleLine.instance.resetRect();
				}
			}
		}
		
		protected function _onXChanged(e:Event):void {
			if (this._curCell) {
				_curCell.x = int(_xTF.text);
				if (ScaleLine.instance.parentCell == _curCell){
					ScaleLine.instance.resetRect();
				}
			}
		}
	}

}
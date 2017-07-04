package view {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import model.Cell;
	import model.KaKou;
	import model.YuanJian;
	/**
	 * ...
	 * @author hongjie
	 */
	public class ShuXingKaKou extends ShuXingYuanJian {
		
		private var _typeTF:TextField;
		
		public function ShuXingKaKou(width:int, height:int) {
			super(width, height, '卡扣');
		}
		
		override protected function _init(width:int, height:int):void {
			var label:TextField = new TextField();
			label.mouseEnabled = false;
			label.text = '距离:';
			label.y = 30;
			addChild(label);
			
			var border:Shape = _drawInputBorder(30, 18);
			border.x = 40;
			border.y = label.y;
			addChild(border);
			_xTF = new TextField();
			_xTF.type = TextFieldType.INPUT;
			_xTF.text = '0';
			_xTF.width = 30;
			_xTF.height = 18;
			_xTF.restrict = '0-9';
			_xTF.x = 40;
			_xTF.y = label.y;
			_xTF.addEventListener(Event.CHANGE, _onXChanged);
			addChild(_xTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '宽度:';
			label.x = 70;
			label.y = 30;
			addChild(label);
			
			border = _drawInputBorder(30, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_widthTF = new TextField();
			_widthTF.type = TextFieldType.INPUT;
			_widthTF.text = '0';
			_widthTF.width = 30;
			_widthTF.height = 18;
			_widthTF.restrict = '0-9';
			_widthTF.x = 40 + label.x;
			_widthTF.y = label.y;
			_widthTF.addEventListener(Event.CHANGE, _onWidthChanged);
			addChild(_widthTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '长度:';
			label.x = 140;
			label.y = 30;
			addChild(label);
			
			border = _drawInputBorder(30, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_heightTF = new TextField();
			_heightTF.type = TextFieldType.INPUT;
			_heightTF.text = '0';
			_heightTF.width = 30;
			_heightTF.height = 18;
			_heightTF.restrict = '0-9';
			_heightTF.x = 40 + label.x;
			_heightTF.y = label.y;
			_heightTF.addEventListener(Event.CHANGE, _onHeightChanged);
			addChild(_heightTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '类型:';
			label.x = 210;
			label.y = 30;
			addChild(label);
			
			border = _drawInputBorder(30, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_typeTF = new TextField();
			_typeTF.type = TextFieldType.INPUT;
			_typeTF.text = '0';
			_typeTF.width = 30;
			_typeTF.height = 18;
			_typeTF.x = 40 + label.x;
			_typeTF.y = label.y;
			_typeTF.addEventListener(Event.CHANGE, _onTypeChanged);
			addChild(_typeTF);
		}
		
		private function _onTypeChanged(e:Event):void {
			(_curCell as KaKou).typeStr = _typeTF.text;
		}
		
		override public function setCurCell(cell:Cell):void {
			_curCell = cell;
			if (cell) {
				this._xTF.text = (cell as KaKou).offsetX.toString();
				this._widthTF.text = cell.reallyWidth.toString();
				this._heightTF.text = cell.reallyHeight.toString();
				_typeTF.text = (cell as KaKou).typeStr;
			}
		}
		
	}

}
package view {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import model.Cell;
	import model.KaKou;
	/**
	 * ...
	 * @author hongjie
	 */
	public class ShuXingKaKou extends ShuXingYuanJian {
		
		public function ShuXingKaKou(width:int, height:int) {
			super(width, height, '卡扣');
		}
		
		override protected function _init(width:int, height:int):void {
			super._init(width, height);
			
			var label:TextField = new TextField();
			label.mouseEnabled = false;
			label.text = '宽度:';
			label.x = 100;
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			var border:Shape = _drawInputBorder(50, 18);
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
			label.x = 200;
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
		
		override public function setCurCell(cell:Cell):void {
			_curCell = cell;
			if (cell) {
				this._xTF.text = (cell as KaKou).offsetX.toString();
				this._widthTF.text = cell.reallyWidth.toString();
				this._heightTF.text = cell.reallyHeight.toString();
			}
		}
		
	}

}
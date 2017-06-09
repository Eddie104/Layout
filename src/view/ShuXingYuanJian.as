package view {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import model.Cell;
	import model.YuanJian;
	/**
	 * ...
	 * @author hongjie
	 */
	public final class ShuXingYuanJian extends ShuXing {
		
		public function ShuXingYuanJian(width:int, height:int) {
			super(width, height, '元件');
		}
		
		override protected function _init(width:int, height:int):void {
			var label:TextField = new TextField();
			label.mouseEnabled = false;
			label.text = '距离:';
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
		}
		
		override public function setCurCell(cell:Cell):void {
			_curCell = cell;
			if (cell){
				this._xTF.text = (cell as YuanJian).offsetX.toString();
			}
		}
		
		override protected function _onXChanged(e:Event):void {
			if (this._curCell) {
				(_curCell as YuanJian).offsetX = int(_xTF.text);
			}
		}
		
	}

}
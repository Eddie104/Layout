package view {
	import flash.display.Shape;
	import flash.display3D.textures.Texture;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import model.Cell;
	import model.YuanJian;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class ShuXingYuanJian extends ShuXing {
		
		protected var _marginTopTF:TextField;
		
		protected var _margionBottomTF:TextField;
		
		protected var _offsetTF:TextField;
		
		protected var _offsetY:TextField;
		
		public function ShuXingYuanJian(width:int, height:int, type:String = '元件') {
			super(width, height, type);
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
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '上轨:';
			label.x = 100;
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			border = _drawInputBorder(50, 18);
			border.x = 40;
			border.y = label.y;
			addChild(border);
			_marginTopTF = new TextField();
			_marginTopTF.mouseEnabled = false;
			//_marginTopTF.type = TextFieldType.INPUT;
			_marginTopTF.text = '0';
			_marginTopTF.width = 50;
			_marginTopTF.height = 18;
			_marginTopTF.restrict = '0-9';
			_marginTopTF.x = 140;
			_marginTopTF.y = label.y;
			//_marginTopTF.addEventListener(Event.CHANGE, _onXChanged);
			addChild(_marginTopTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '下轨:';
			label.x = 180;
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			border = _drawInputBorder(50, 18);
			border.x = 40;
			border.y = label.y;
			addChild(border);
			_margionBottomTF = new TextField();
			_margionBottomTF.mouseEnabled = false;
			//_margionBottomTF.type = TextFieldType.INPUT;
			_margionBottomTF.text = '0';
			_margionBottomTF.width = 50;
			_margionBottomTF.height = 18;
			_margionBottomTF.restrict = '0-9';
			_margionBottomTF.x = 220;
			_margionBottomTF.y = label.y;
			//_margionBottomTF.addEventListener(Event.CHANGE, _onXChanged);
			addChild(_margionBottomTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '调整值:';
			label.x = 0;
			label.y = 60;
			addChild(label);
			
			border = _drawInputBorder(30, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_offsetTF = new TextField();
			_offsetTF.type = TextFieldType.INPUT;
			_offsetTF.text = '0';
			_offsetTF.width = 30;
			_offsetTF.height = 18;
			_offsetTF.x = 40 + label.x;
			_offsetTF.y = label.y;
			_offsetTF.addEventListener(Event.CHANGE, _onOffsetChanged);
			addChild(_offsetTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '调整值:';
			label.x = 260;
			label.y = (height - label.textHeight) >> 1;
			addChild(label);
			
			border = _drawInputBorder(30, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_offsetY = new TextField();
			_offsetY.type = TextFieldType.INPUT;
			_offsetY.text = '0';
			_offsetY.width = 30;
			_offsetY.height = 18;
			_offsetY.x = 40 + label.x;
			_offsetY.y = label.y;
			_offsetY.addEventListener(Event.CHANGE, _onOffsetYChanged);
			addChild(_offsetY);
		}
		
		override public function setCurCell(cell:Cell):void {
			_curCell = cell;
			if (cell) {
				var yuanJian:YuanJian = cell as YuanJian;
				this._xTF.text = yuanJian.offsetX.toString();
				_marginTopTF.text = yuanJian.marginTopToXianCao.toString();
				_margionBottomTF.text = yuanJian.marginBottomToXianCao.toString();
				_offsetTF.text = ScaleLine.OFFSET.toString();
				this._offsetY.text = yuanJian.offsetY.toString();
			}
		}
		
		private function _onOffsetChanged(e:Event):void {
			ScaleLine.OFFSET = int(_offsetTF.text);
		}
		
		private function _onOffsetYChanged(e:Event):void {
			if (this._curCell) {
				(_curCell as YuanJian).offsetY = int(_offsetY.text);
			}
		}
		
		override protected function _onXChanged(e:Event):void {
			if (this._curCell) {
				(_curCell as YuanJian).offsetX = int(_xTF.text);
				if (ScaleLine.instance.parentCell == _curCell) {
					ScaleLine.instance.resetRect();
				}
			}
		}
	
	}

}
package view {
	import flash.display.Shape;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import model.Cell;
	import model.GuiDao;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class ShuXingGuiDao extends ShuXing {
		
		private var _typeTF:TextField;
		
		public function ShuXingGuiDao(width:int, height:int) {
			super(width, height, '轨道');
		}
		
		override protected function _init(width:int, height:int):void {
			var label:TextField = new TextField();
			label.mouseEnabled = false;
			label.text = '坐标X:';
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
			label.text = '坐标Y:';
			label.x = 70;
			label.y = 30;
			addChild(label);
			
			border = _drawInputBorder(30, 18);
			border.x = 40 + label.x;
			border.y = label.y;
			addChild(border);
			_yTF = new TextField();
			_yTF.type = TextFieldType.INPUT;
			_yTF.text = '0';
			_yTF.width = 30;
			_yTF.height = 18;
			_yTF.restrict = '0-9';
			_yTF.x = 40 + label.x;
			_yTF.y = label.y;
			_yTF.addEventListener(Event.CHANGE, _onYChanged);
			addChild(_yTF);
			
			label = new TextField();
			label.mouseEnabled = false;
			label.text = '宽度:';
			label.x = 140;
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
			label.x = 210;
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
			label.x = 280;
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
		
		override public function setCurCell(cell:Cell):void {
			super.setCurCell(cell);
			if (guiDao.isJiaDe) {
				_heightTF.mouseEnabled = false;
				_typeLabel.text = '虚拟轨道';
			} else {
				_typeLabel.text = '轨道';
			}
			_widthTF.text = cell.reallyHeight.toString();
			_heightTF.text = cell.reallyWidth.toString();
			
			_typeTF.text = (cell as GuiDao).typeStr;
		}
		
		private function _onTypeChanged(e:Event):void {
			(_curCell as GuiDao).typeStr = _typeTF.text;
		}
		
		override protected function _onHeightChanged(e:Event):void {
			if (_curCell) {
				_curCell.setSize(int(_heightTF.text), _curCell.reallyHeight);
				if (ScaleLine.instance.parentCell == _curCell){
					ScaleLine.instance.resetRect();
				}
			}
		}
		
		override protected function _onWidthChanged(e:Event):void {
			if (_curCell) {
				_curCell.setSize(_curCell.reallyWidth, int(_widthTF.text));
				if (ScaleLine.instance.parentCell == _curCell){
					ScaleLine.instance.resetRect();
				}
			}
		}
		
		private function get guiDao():GuiDao {
			return this._curCell as GuiDao;
		}
	
	}

}
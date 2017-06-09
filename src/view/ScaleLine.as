package view {
	import events.LayoutEvent;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import model.Cell;
	import model.GuiDao;
	import model.YuanJian;
	
	/**
	 * ...
	 * @author 鸿杰
	 */
	public class ScaleLine extends Sprite {
		
		private static var _instance:ScaleLine;
		
		private var _leftTopRect:ScaleRect;
		
		private var _topRect:ScaleRect;
		
		private var _rightTopRect:ScaleRect;
		
		private var _rightRect:ScaleRect;
		
		private var _rightBottomRect:ScaleRect;
		
		private var _bottomRect:ScaleRect;
		
		private var _leftBottomRect:ScaleRect;
		
		private var _leftRect:ScaleRect;
		
		private var _centerRect:ScaleRect;
		
		private var _movingRect:ScaleRect;
		
		private var _lastX:int;
		
		private var _lastY:int;
		
		private var _parent:Cell;
		
		public function ScaleLine() {
			super();
			
			_leftTopRect = initRect();
			_topRect = initRect();
			_rightTopRect = initRect();
			_rightRect = initRect();
			_rightBottomRect = initRect();
			_bottomRect = initRect();
			_leftBottomRect = initRect();
			_leftRect = initRect();
			_centerRect = initRect();
		}
		
		private function initRect():ScaleRect {
			var r:ScaleRect = new ScaleRect();
			addChild(r);
			r.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDown);
			return r;
		}
		
		public function set parentCell(val:Cell):void {
			if (this.parent) {
				this.parent.removeChild(this);
			}
			_parent = val;
			if (_parent) {
				_parent.addChild(this);
				resetRect();
			} else {
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL));
			}
		}
		
		private function resetRect():void {
			_leftTopRect.x = 0;
			_leftTopRect.y = 0;
			_topRect.x = _parent.reallyWidth >> 1;
			_topRect.y = 0;
			_rightTopRect.x = _parent.reallyWidth;
			_rightTopRect.y = 0;
			_rightRect.x = _parent.reallyWidth;
			_rightRect.y = _parent.reallyHeight >> 1;
			_rightBottomRect.x = _parent.reallyWidth;
			_rightBottomRect.y = _parent.reallyHeight;
			_bottomRect.x = _parent.reallyWidth >> 1;
			_bottomRect.y = _parent.reallyHeight;
			_leftBottomRect.x = 0;
			_leftBottomRect.y = _parent.reallyHeight;
			_leftRect.x = 0;
			_leftRect.y = _parent.reallyHeight >> 1;
			_centerRect.x = _parent.reallyWidth >> 1;
			_centerRect.y = _parent.reallyHeight >> 1;
			
			if ((_parent is GuiDao && (_parent as GuiDao).isJiaDe) || _parent is YuanJian) {
				_leftTopRect.isEnabeld = false;
				_topRect.isEnabeld = false;
				_rightTopRect.isEnabeld = false;
				_rightRect.isEnabeld = false;
				_rightBottomRect.isEnabeld = false;
				_bottomRect.isEnabeld = false;
				_leftBottomRect.isEnabeld = false;
				_leftRect.isEnabeld = false;
				_centerRect.isEnabeld = true;
			} else {
				_leftTopRect.isEnabeld = true;
				_topRect.isEnabeld = true;
				_rightTopRect.isEnabeld = true;
				_rightRect.isEnabeld = true;
				_rightBottomRect.isEnabeld = true;
				_bottomRect.isEnabeld = true;
				_leftBottomRect.isEnabeld = true;
				_leftRect.isEnabeld = true;
				_centerRect.isEnabeld = true;
			}
		}
		
		public static function get instance():ScaleLine {
			if (!ScaleLine._instance) {
				ScaleLine._instance = new ScaleLine();
			}
			return ScaleLine._instance;
		}
		
		private function onMouseDown(evt:MouseEvent):void {
			_movingRect = evt.currentTarget as ScaleRect;
			_lastX = evt.stageX;
			_lastY = evt.stageY;
		}
		
		public function mouseMoved(stageX:int, stageY:int):void {
			if (_movingRect && _movingRect.isEnabeld) {
				if (_centerRect != _movingRect) {
					_movingRect.x += stageX - _lastX;
					_movingRect.y += stageY - _lastY;
				}
				
				switch (_movingRect) {
				case _leftTopRect: 
					var p:Point = this.localToGlobal(new Point(_movingRect.x, _movingRect.y));
					_parent.x = p.x;
					_parent.y = p.y;
					_parent.setSize(_rightTopRect.x - _leftTopRect.x, _rightBottomRect.y - _movingRect.y);
					break;
				case _topRect: 
					_parent.y = this.localToGlobal(new Point(_movingRect.x, _movingRect.y)).y;
					_parent.setSize(-1, _rightBottomRect.y - _movingRect.y);
					break;
				case _rightTopRect: 
					p = this.localToGlobal(new Point(_movingRect.x, _movingRect.y));
					_parent.y = p.y;
					_parent.setSize(_rightTopRect.x - _leftTopRect.x, _rightBottomRect.y - _movingRect.y);
					break;
				case _rightRect: 
					_parent.setSize(_rightRect.x - _leftTopRect.x);
					break;
				case _rightBottomRect: 
					_parent.setSize(_rightBottomRect.x - _leftTopRect.x, _rightBottomRect.y - _rightTopRect.y);
					break;
				case _bottomRect: 
					_parent.setSize(-1, _bottomRect.y - _rightTopRect.y);
					break;
				case _leftBottomRect: 
					_parent.x = this.localToGlobal(new Point(_movingRect.x, _movingRect.y)).x;
					_parent.setSize(_rightBottomRect.x - _leftBottomRect.x, _leftBottomRect.y - _rightTopRect.y);
					break;
				case _leftRect: 
					_parent.x = this.localToGlobal(new Point(_movingRect.x, _movingRect.y)).x;
					_parent.setSize(_rightRect.x - _leftRect.x);
					break;
				case _centerRect: 
					if (_parent is YuanJian) {
						(_parent as YuanJian).offsetX += stageX - _lastX;
					} else {
						_parent.y += stageY - _lastY;
						if (!(_parent is GuiDao) || !((_parent as GuiDao).isJiaDe)) {
							_parent.x += stageX - _lastX;
						}
					}
					break;
				}
				resetRect();
				_lastX = stageX;
				_lastY = stageY;
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL, null, null, false, _parent));
			}
		}
		
		public function mouseUped():void {
			_movingRect = null;
		}
	}

}
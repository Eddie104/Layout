package view {
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import model.Cell;
	import model.GuiDao;
	import model.KaKou;
	import model.XianCao;
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
		
		private var _centerRightRect:ScaleRect;
		
		private var _centerTopRect:ScaleRect;
		
		private var _movingRect:ScaleRect;
		
		private var _lastX:int;
		
		private var _lastY:int;
		
		private var _parent:Cell;
		
		private var _copyBtn:Sprite;
		
		private var _deleteBtn:Sprite;
		
		public function ScaleLine() {
			super();
			
			this.mouseEnabled = false;
			
			_leftTopRect = initRect();
			_topRect = initRect();
			_rightTopRect = initRect();
			_rightRect = initRect();
			_rightBottomRect = initRect();
			_bottomRect = initRect();
			_leftBottomRect = initRect();
			_leftRect = initRect();
			_centerRect = initRect();
			_centerRightRect = initRect();
			_centerTopRect = initRect();
			
			_copyBtn = _createBtn('复制');
			_copyBtn.addEventListener(MouseEvent.CLICK, _onCopy);
			_deleteBtn = _createBtn('删除');
			_deleteBtn.addEventListener(MouseEvent.CLICK, _onDelete);
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
				_resetBtn();
			} else {
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL));
			}
		}
		
		public function get parentCell():Cell {
			return this._parent;
		}
		
		private function _resetBtn():void {
			if (_parent is GuiDao || _parent is XianCao) {
				if (_parent is GuiDao && (_parent as GuiDao).isJiaDe) {
					if (_copyBtn.parent == this) {
						removeChild(_copyBtn);
					}
				} else {
					if (_copyBtn.parent != this) {
						addChild(_copyBtn);
					}
				}
				
				if (_deleteBtn.parent != this) {
					addChild(_deleteBtn);
				}
				_copyBtn.x = 0;
				_copyBtn.y = _parent.reallyHeight + 10;
				_deleteBtn.x = _copyBtn.parent == this ? 50 : 0;
				_deleteBtn.y = _parent.reallyHeight + 10;
			} else {
				if (_copyBtn.parent == this) {
					removeChild(_copyBtn);
				}
				if (_parent is YuanJian) {
					if (_deleteBtn.parent != this) {
						addChild(_deleteBtn);
					}
					_deleteBtn.x = 0;
					_deleteBtn.y = _parent.reallyHeight;
				} else {
					if (_deleteBtn.parent == this) {
						removeChild(_deleteBtn);
					}
				}
			}
		}
		
		private function _onCopy(e:MouseEvent):void {
			dispatchEvent(new LayoutEvent(LayoutEvent.COPY));
			e.stopImmediatePropagation();
		}
		
		private function _onDelete(e:MouseEvent):void {
			dispatchEvent(new LayoutEvent(LayoutEvent.DELETE));
			e.stopImmediatePropagation();
		}
		
		public function resetRect():void {
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
			_centerRightRect.x = _centerRect.x + 10;
			_centerRightRect.y = _centerRect.y;
			_centerTopRect.x = _centerRect.x;
			_centerTopRect.y = _centerRect.y - 10;
			
			/*if (_parent is KaKou){
			   _leftTopRect.isEnabeld = true;
			   _topRect.isEnabeld = true;
			   _rightTopRect.isEnabeld = true;
			   _rightRect.isEnabeld = true;
			   _rightBottomRect.isEnabeld = true;
			   _bottomRect.isEnabeld = true;
			   _leftBottomRect.isEnabeld = true;
			   _leftRect.isEnabeld = true;
			   _centerRect.isEnabeld = true;
			   } else */
			if (/*(_parent is GuiDao && (_parent as GuiDao).isJiaDe) || */_parent is YuanJian) {
				_leftTopRect.isEnabeld = false;
				_topRect.isEnabeld = false;
				_rightTopRect.isEnabeld = false;
				_rightRect.isEnabeld = false;
				_rightBottomRect.isEnabeld = false;
				_bottomRect.isEnabeld = false;
				_leftBottomRect.isEnabeld = false;
				_leftRect.isEnabeld = false;
				_centerRect.isEnabeld = true;
				_centerTopRect.isEnabeld = false;
			} else if (_parent is XianCao) {
				const xianCao:XianCao = _parent as XianCao;
				if (xianCao.dir == Enum.H) {
					_leftTopRect.isEnabeld = false;
					_topRect.isEnabeld = false;
					_rightTopRect.isEnabeld = false;
					_rightRect.isEnabeld = true;
					_rightBottomRect.isEnabeld = false;
					_bottomRect.isEnabeld = false;
					_leftBottomRect.isEnabeld = false;
					_leftRect.isEnabeld = true;
					_centerRect.isEnabeld = true;
					_centerTopRect.isEnabeld = true;
				} else {
					_leftTopRect.isEnabeld = false;
					_topRect.isEnabeld = true;
					_rightTopRect.isEnabeld = false;
					_rightRect.isEnabeld = false;
					_rightBottomRect.isEnabeld = false;
					_bottomRect.isEnabeld = true;
					_leftBottomRect.isEnabeld = false;
					_leftRect.isEnabeld = false;
					_centerRect.isEnabeld = true;
					_centerTopRect.isEnabeld = true;
				}
			} else if (_parent is GuiDao) {
				_leftTopRect.isEnabeld = false;
				_topRect.isEnabeld = false;
				_rightTopRect.isEnabeld = false;
				_rightRect.isEnabeld = true;
				_rightBottomRect.isEnabeld = false;
				_bottomRect.isEnabeld = false;
				_leftBottomRect.isEnabeld = false;
				_leftRect.isEnabeld = true;
				_centerRect.isEnabeld = true;
				_centerTopRect.isEnabeld = true;
			} else {
				_leftTopRect.isEnabeld = false;
				_topRect.isEnabeld = true;
				_rightTopRect.isEnabeld = false;
				_rightRect.isEnabeld = false;
				_rightBottomRect.isEnabeld = false;
				_bottomRect.isEnabeld = true;
				_leftBottomRect.isEnabeld = false;
				_leftRect.isEnabeld = false;
				_centerRect.isEnabeld = true;
				_centerTopRect.isEnabeld = true;
			}
		}
		
		private function onMouseDown(evt:MouseEvent):void {
			_movingRect = evt.currentTarget as ScaleRect;
			_lastX = evt.stageX;
			_lastY = evt.stageY;
			evt.stopImmediatePropagation();
		}
		
		private function _createBtn(name:String):Sprite {
			var s:Sprite = new Sprite();
			s.mouseChildren = false;
			const g:Graphics = s.graphics;
			g.beginFill(0x00ff00);
			g.drawRect(0, 0, 40, 20);
			g.endFill();
			s.width = 40;
			s.height = 20;
			var tf:TextField = new TextField();
			tf.mouseEnabled = false;
			tf.width = 40;
			tf.height = 20;
			tf.text = name;
			tf.x = (40 - tf.textWidth) >> 1;
			tf.y = (20 - tf.textHeight) >> 1;
			s.addChild(tf);
			return s;
		}
		
		public static function get instance():ScaleLine {
			if (!ScaleLine._instance) {
				ScaleLine._instance = new ScaleLine();
			}
			return ScaleLine._instance;
		}
		
		public function mouseMoved(stageX:int, stageY:int):Boolean {
			if (_parent && _movingRect && _movingRect.isEnabeld) {
				var vx:Number = (stageX - _lastX);// / BuJuQu.containerScale;
				var vy:Number = (stageY - _lastY);// / BuJuQu.containerScale;
				if (_centerRect != _movingRect && _centerRightRect != _movingRect && _centerTopRect != _movingRect) {
					_movingRect.x += vx;
					_movingRect.y += vy;
				}
				
				switch (_movingRect) {
				case _leftTopRect: 
					var p:Point = this.localToGlobal(new Point(_movingRect.x, _movingRect.y));
					_parent.x = p.x / BuJuQu.containerScale;
					_parent.y = p.y / BuJuQu.containerScale;
					_parent.setSize(_rightTopRect.x - _leftTopRect.x, _rightBottomRect.y - _movingRect.y);
					break;
				case _topRect: 
					//_parent.y = this.localToGlobal(new Point(_movingRect.x, _movingRect.y)).y / BuJuQu.containerScale;
					//_parent.setSize(-1, _rightBottomRect.y - _movingRect.y);
					_parent.y += vy;
					_parent.setSize(-1, _rightBottomRect.y - _movingRect.y);
					break;
				case _rightTopRect: 
					p = this.localToGlobal(new Point(_movingRect.x, _movingRect.y));
					_parent.y = p.y / BuJuQu.containerScale;
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
					_parent.x = this.localToGlobal(new Point(_movingRect.x, _movingRect.y)).x / BuJuQu.containerScale;
					_parent.setSize(_rightBottomRect.x - _leftBottomRect.x, _leftBottomRect.y - _rightTopRect.y);
					break;
				case _leftRect: 
					_parent.x += vx;
					_parent.setSize(_rightRect.x - _leftRect.x);
					break;
				case _centerRect: 
					if (_parent is YuanJian) {
						//var guiDao:GuiDao;
						//const arr:Array = Main.mainScene.buJuQu.getObjectsUnderPoint(new Point(stageX, stageY));
						//for (var i:int = 0; i < arr.length; i++) {
							//if (arr[i] is GuiDao) {
								//guiDao = arr[i] as GuiDao;
								//if (guiDao == this._parent.parent) {
									//(_parent as YuanJian).offsetX += stageX - _lastX;
									//break;
								//}
							//}
						//}
						var yuanJianArr:Vector.<YuanJian> = new Vector.<YuanJian>();
						yuanJianArr[0] = _parent as YuanJian;
						dispatchEvent(new LayoutEvent(LayoutEvent.START_TO_DTAG_YUAN_JIAN, null, null, false, null, null, yuanJianArr));
						return false;
					} else {
						var maxX:Number = Main.mainScene.buJuQu.w - _parent.reallyWidth;
						var maxY:Number = Main.mainScene.buJuQu.h - _parent.reallyHeight;
						var y:Number = _parent.y + (stageY - _lastY) / BuJuQu.containerScale;
						if (y < 0) y = 0;
						else if (y > maxY) y = maxY;
						_parent.y = y;
						//_parent.y += (stageY - _lastY) / BuJuQu.containerScale;
						//if (!(_parent is GuiDao) || !((_parent as GuiDao).isJiaDe)) {
						var x:Number = _parent.x + (stageX - _lastX) / BuJuQu.containerScale;
						if (x < 0) x = 0;
						else if (x > maxX) x = maxX;
						_parent.x = x;
							//_parent.x += (stageX - _lastX) / BuJuQu.containerScale;
							//}
					}
					break;
				case _centerTopRect: 
					if (_parent is YuanJian) {
						
					} else {
						maxY = Main.mainScene.buJuQu.h - _parent.reallyHeight;
						y = _parent.y + (stageY - _lastY) / BuJuQu.containerScale;
						if (y < 0) y = 0;
						else if (y > maxY) y = maxY;
						_parent.y = y;
					}
					break;
				case _centerRightRect: 
					if (_parent is YuanJian) {
						var guiDao:GuiDao;
						const arr:Array = Main.mainScene.buJuQu.getObjectsUnderPoint(new Point(stageX, stageY));
						for (var i:int = 0; i < arr.length; i++) {
							if (arr[i] is GuiDao) {
								guiDao = arr[i] as GuiDao;
								if (guiDao == this._parent.parent) {
									(_parent as YuanJian).offsetX += stageX - _lastX;
									break;
								}
							}
						}
					} else {
						maxX = Main.mainScene.buJuQu.w - _parent.reallyWidth;
						x = _parent.x + (stageX - _lastX) / BuJuQu.containerScale;
						if (x < 0) x = 0;
						else if (x > maxX) x = maxX;
						_parent.x = x;
					}
					break;
				}
				resetRect();
				_resetBtn();
				_lastX = stageX;
				_lastY = stageY;
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL, null, null, false, _parent));
				return true;
			}
			return false;
		}
		
		public function moveUp():void {
			if (_parent) {
				_parent.y -= 1;
				resetRect();
				_resetBtn();
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL, null, null, false, _parent));
			}
		}
		
		public function moveRight():void {
			if (_parent) {
				_parent.x += 1;
				resetRect();
				_resetBtn();
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL, null, null, false, _parent));
			}
		}
		
		public function moveDown():void {
			if (_parent) {
				_parent.y += 1;
				resetRect();
				_resetBtn();
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL, null, null, false, _parent));
			}
		}
		
		public function moveLeft():void {
			if (_parent) {
				_parent.x -= 1;
				resetRect();
				_resetBtn();
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL, null, null, false, _parent));
			}
		}
		
		public function mouseUped():void {
			_movingRect = null;
			if (_parent) {
				_parent.x = int(_parent.x);
				_parent.y = int(_parent.y);
				resetRect();
				_resetBtn();
				dispatchEvent(new LayoutEvent(LayoutEvent.UPDATE_CELL, null, null, false, _parent));
			}
		}
	}

}
package view {
	import config.ConfigUtil;
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.KeyboardEvent;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.ui.Keyboard;
	import model.GuiDao;
	import model.YuanJian;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class MainScene extends Sprite {
		
		private var _buJuQu:BuJuQu;
		
		private var _yuanJianQu:YuanJianQu;
		
		private var _shuXingQu:ShuXingQu;
		
		private var _kongZhiQu:KongZhiQu;
		
		private var _dragingBitmap:DragingBitmap;
		
		private var _isDraging:Boolean;
		
		private var _lastX:int;
		
		private var _lastY:int;
		
		private var _keyPoll:KeyPoll;
		
		public function MainScene(width:int, height:int) {
			super();
			
			const g:Graphics = this.graphics;
			g.beginFill(0, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
			
			const stageWidth:int = width;
			const stageHeight:int = height;
			const bottomPanelHeight:int = 80;
			
			_buJuQu = new BuJuQu(stageWidth >> 1, stageHeight - bottomPanelHeight);
			addChild(_buJuQu);
			
			_yuanJianQu = new YuanJianQu(stageWidth >> 1, stageHeight - bottomPanelHeight);
			_yuanJianQu.x = stageWidth >> 1;
			_yuanJianQu.addEventListener(LayoutEvent.START_TO_DTAG_YUAN_JIAN, _onStartToDragYuanJian);
			addChild(_yuanJianQu);
			
			_shuXingQu = new ShuXingQu(stageWidth >> 1, bottomPanelHeight, _buJuQu);
			_shuXingQu.y = stageHeight - bottomPanelHeight;
			addChild(_shuXingQu);
			
			_kongZhiQu = new KongZhiQu(stageWidth >> 1, bottomPanelHeight);
			_kongZhiQu.x = stageWidth >> 1;
			_kongZhiQu.y = stageHeight - bottomPanelHeight;
			_kongZhiQu.addEventListener(LayoutEvent.IMPORT_XML, _onImportXML);
			_kongZhiQu.addEventListener(LayoutEvent.ADD_GUI_DAO, _onAddGuiDao);
			_kongZhiQu.addEventListener(LayoutEvent.ADD_JIA_GUI_DAO, _onAddJiaGuiDao);
			_kongZhiQu.addEventListener(LayoutEvent.ADD_XIAN_CAO, _onAddXianCao);
			addChild(_kongZhiQu);
			
			_dragingBitmap = new DragingBitmap();
			addChild(_dragingBitmap);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMoved);
		}
		
		private function _onStartToDragYuanJian(e:LayoutEvent):void {
			const yuanJian:YuanJian = e.yuanJian;
			_dragingBitmap.yuanJian = yuanJian;
			const p:Point = _yuanJianQu.localToGlobal(new Point(yuanJian.x, yuanJian.y));
			_dragingBitmap.x = p.x;
			_dragingBitmap.y = p.y;
			_isDraging = true;
		}
		
		private function _onAddXianCao(e:LayoutEvent):void {
			_buJuQu.addXianCao();
		}
		
		private function _onAddGuiDao(e:LayoutEvent):void {
			_buJuQu.addGuiDao(false);
		}
		
		private function _onAddJiaGuiDao(e:LayoutEvent):void {
			_buJuQu.addGuiDao(true);
		}
		
		private function _onImportXML(e:LayoutEvent):void {
			ConfigUtil.instance.loadXML();
			//if (!this.stage.hasEventListener(KeyboardEvent.KEY_UP)) {
				//this.stage.addEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);
			//}
			if (!_keyPoll){
				_keyPoll = new KeyPoll(this.stage);
				_keyPoll.addEventListener(KeyboardEvent.KEY_UP, this._onKeyUp);
			}
		}
		
		private function _onKeyUp(e:KeyboardEvent):void {
			//if (e.ctrlKey) {
				//if (e.keyCode == Keyboard.C) {
					//_buJuQu.copyCell();
				//} else if (e.keyCode == Keyboard.V) {
					//_buJuQu.pasteCell();
				//}
			//}
			if (_keyPoll.isDown(Keyboard.CONTROL)){
				if (e.keyCode == Keyboard.C){
					_buJuQu.copyCell();
					trace('copy');
				} else if (e.keyCode == Keyboard.V){
					_buJuQu.pasteCell();
					trace('paste');
				}
			}
		}
		
		private function _onMouseDown(e:MouseEvent):void {
			_lastX = e.stageX;
			_lastY = e.stageY;
		}
		
		private function _onMouseUp(e:MouseEvent):void {
			if (_isDraging) {
				_isDraging = false;
				var guiDao:GuiDao = null;
				const cellArr:Array = this.getObjectsUnderPoint(new Point(e.stageX, e.stageY));
				for (var i:int = 0; i < cellArr.length; i++) {
					if (cellArr[i] is GuiDao) {
						guiDao = cellArr[i] as GuiDao;
						break;
					}
				}
				if (guiDao) {
					guiDao.addYuanJian(_dragingBitmap.yuanJian, guiDao.globalToLocal(new Point(e.stageX, e.stageY)));
				}
				if (_dragingBitmap.bitmapData) {
					_dragingBitmap.bitmapData.dispose();
					_dragingBitmap.bitmapData = null;
				}
			}
		}
		
		private function _onMouseMoved(e:MouseEvent):void {
			if (_isDraging) {
				_dragingBitmap.x += e.stageX - _lastX;
				_dragingBitmap.y += e.stageY - _lastY;
				_lastX = e.stageX;
				_lastY = e.stageY;
			}
		}
	
	}

}
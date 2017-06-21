package view {
	import config.ConfigUtil;
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import model.GuiDao;
	import model.KaKou;
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
			_buJuQu.addEventListener(LayoutEvent.RESET_YUAN_JIAN, _onResetYuanJian);
			
			_yuanJianQu = new YuanJianQu(stageWidth >> 1, stageHeight - bottomPanelHeight);
			_yuanJianQu.x = stageWidth >> 1;
			_yuanJianQu.addEventListener(LayoutEvent.START_TO_DTAG_YUAN_JIAN, _onStartToDragYuanJian);
			_yuanJianQu.addEventListener(LayoutEvent.START_TO_DTAG_V_XIAN_CAO, _onStartToDragVXianCao);
			_yuanJianQu.addEventListener(LayoutEvent.START_TO_DTAG_H_XIAN_CAO, _onStartToDragHXianCao);
			_yuanJianQu.addEventListener(LayoutEvent.START_TO_DTAG_GUI_DAO, _onStartToDragGuiDao);
			_yuanJianQu.addEventListener(LayoutEvent.START_TO_DTAG_JIA_GUI_DAO, _onStartToDragJiaGuiDao);
			_yuanJianQu.addEventListener(LayoutEvent.START_TO_DTAG_KA_KOU, _onStartToDragKaKou);
			_yuanJianQu.addEventListener(LayoutEvent.YUAN_JIAN_QU_INITED, _onYuanJianQuInited);
			addChild(_yuanJianQu);
			
			_shuXingQu = new ShuXingQu(stageWidth >> 1, bottomPanelHeight, _buJuQu);
			_shuXingQu.y = stageHeight - bottomPanelHeight;
			addChild(_shuXingQu);
			
			_kongZhiQu = new KongZhiQu(stageWidth >> 1, bottomPanelHeight);
			_kongZhiQu.x = stageWidth >> 1;
			_kongZhiQu.y = stageHeight - bottomPanelHeight;
			_kongZhiQu.addEventListener(LayoutEvent.IMPORT_XML, _onImportXML);
			addChild(_kongZhiQu);
			
			_dragingBitmap = new DragingBitmap();
			addChild(_dragingBitmap);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMoved);
		}
		
		public function get buJuQu():BuJuQu{
			return this._buJuQu;
		}
		
		private function _onResetYuanJian(e:LayoutEvent):void {
			e.yuanJian.isSelected = false;
			if (e.yuanJian is KaKou){
				return;
			}
			e.yuanJian.x = e.yuanJian.yuanJianX;
			e.yuanJian.y = e.yuanJian.yuanJianY;
			e.yuanJian.guiDao = null;
			e.yuanJian.offsetX = 0;
			this._yuanJianQu.addYuanJian(e.yuanJian);
			var yuanJian:YuanJian = e.yuanJian.topYuanJian;
			if (yuanJian) {
				if (e.yuanJian.isOnGuiDao) {
					yuanJian.x = yuanJian.yuanJianX;
					yuanJian.y = yuanJian.yuanJianY;
					yuanJian.guiDao = null;
					yuanJian.offsetX = 0;
					this._yuanJianQu.addYuanJian(yuanJian);
					
					
				}
				e.yuanJian.topYuanJian = null;
				yuanJian.bottomYuanJian = null;
			}
			yuanJian = e.yuanJian.bottomYuanJian;
			if (yuanJian) {
				if (e.yuanJian.isOnGuiDao) {
					yuanJian.x = yuanJian.yuanJianX;
					yuanJian.y = yuanJian.yuanJianY;
					yuanJian.guiDao = null;
					yuanJian.offsetX = 0;
					this._yuanJianQu.addYuanJian(yuanJian);	
				}
				e.yuanJian.bottomYuanJian = null;
				yuanJian.topYuanJian = null;
			}
		}
		
		private function _onStartToDragYuanJian(e:LayoutEvent):void {
			const yuanJian:YuanJian = e.yuanJian;
			_dragingBitmap.yuanJian = yuanJian;
			//const p:Point = _yuanJianQu.localToGlobal(new Point(yuanJian.x, yuanJian.y));
			const p:Point = new Point(mouseX, mouseY);
			_dragingBitmap.x = p.x;
			_dragingBitmap.y = p.y;
			_isDraging = true;
			this.mouseChildren = false;
		}
		
		private function _onStartToDragVXianCao(e:LayoutEvent):void {
			_dragingBitmap.subType = Enum.V_XIAN_CAO;
			const p:Point = new Point(mouseX, mouseY);
			_dragingBitmap.x = p.x;
			_dragingBitmap.y = p.y;
			_isDraging = true;
			this.mouseChildren = false;
		}
		
		private function _onStartToDragHXianCao(e:LayoutEvent):void {
			_dragingBitmap.subType = Enum.H_XIAN_CAO;
			const p:Point = new Point(mouseX, mouseY);
			_dragingBitmap.x = p.x;
			_dragingBitmap.y = p.y;
			_isDraging = true;
			this.mouseChildren = false;
		}
		
		private function _onStartToDragGuiDao(e:LayoutEvent):void {
			_dragingBitmap.subType = Enum.GUI_DAO;
			const p:Point = new Point(mouseX, mouseY);
			_dragingBitmap.x = p.x;
			_dragingBitmap.y = p.y;
			_isDraging = true;
			this.mouseChildren = false;
		}
		
		private function _onStartToDragJiaGuiDao(e:LayoutEvent):void {
			_dragingBitmap.subType = Enum.JIA_GUI_DAO;
			const p:Point = new Point(mouseX, mouseY);
			_dragingBitmap.x = p.x;
			_dragingBitmap.y = p.y;
			_isDraging = true;
			this.mouseChildren = false;
		}
		
		private function _onStartToDragKaKou(e:LayoutEvent):void {
			_dragingBitmap.subType = Enum.KA_KOU;
			const p:Point = new Point(mouseX, mouseY);
			_dragingBitmap.x = p.x;
			_dragingBitmap.y = p.y;
			_isDraging = true;
			this.mouseChildren = false;
		}
		
		private function _onImportXML(e:LayoutEvent):void {
			ConfigUtil.instance.loadXML();
		}
		
		private function _onMouseDown(e:MouseEvent):void {
			_lastX = e.stageX;
			_lastY = e.stageY;
		}
		
		private function _onMouseUp(e:MouseEvent):void {
			if (_isDraging) {
				_isDraging = false;
				this.mouseChildren = true;
				// 判断鼠标是否在布局区
				const arr:Array = this.getObjectsUnderPoint(new Point(e.stageX, e.stageY));
				var b:Boolean = false;
				for (var i:int = 0; i < arr.length; i++) {
					if (arr[i] is BuJuQu) {
						b = true;
						break;
					}
				}
				if (b) {
					if (_dragingBitmap.subType == Enum.V_XIAN_CAO) {
						_buJuQu.addXianCao(DragingBitmap.V_XIAN_CAO_W, DragingBitmap.V_XIAN_CAO_H, e.stageX, e.stageY);
					} else if (_dragingBitmap.subType == Enum.H_XIAN_CAO) {
						_buJuQu.addXianCao(DragingBitmap.H_XIAN_CAO_W, DragingBitmap.H_XIAN_CAO_H, e.stageX, e.stageY);
					} else if (_dragingBitmap.subType == Enum.GUI_DAO) {
						_buJuQu.addGuiDao(false, DragingBitmap.GUI_DAO_W, DragingBitmap.GUI_DAO_H, e.stageX, e.stageY);
					} else if (_dragingBitmap.subType == Enum.KA_KOU) {
						var p:Point = new Point(e.stageX, e.stageY);
						var guiDao:GuiDao = null;
						cellArr = this.getObjectsUnderPoint(p);
						for (i = cellArr.length - 1; i > -1; i--) {
							if (cellArr[i] is GuiDao) {
								guiDao = cellArr[i] as GuiDao;
								break;
							}
						}
						if (guiDao) {
							guiDao.addKaKou(guiDao.globalToLocal(p));
						}
					} else if (_dragingBitmap.subType == Enum.JIA_GUI_DAO) {
						_buJuQu.addGuiDao(true, DragingBitmap.GUI_DAO_W, DragingBitmap.GUI_DAO_H, e.stageX, e.stageY);
					} else {
						// 首先判断鼠标点上下10px范围内是否有元件，有的话，就吸附在该元件上
						var targetYuanJian:YuanJian = null;
						p = new Point(e.stageX, e.stageY);
						p.y -= 10;
						var cellArr:Array = getObjectsUnderPoint(p);
						for (i = cellArr.length - 1; i > -1; i--) {
							if (cellArr[i] is YuanJian) {
								targetYuanJian = cellArr[i] as YuanJian;
								break;
							}
						}
						if (targetYuanJian && !targetYuanJian.isKaKou && targetYuanJian.isOnGuiDao && targetYuanJian.bottomYuanJian == null) {
							targetYuanJian.bottomYuanJian = _dragingBitmap.yuanJian;
						} else {
							p.y += 20;
							cellArr = getObjectsUnderPoint(p);
							for (i = cellArr.length - 1; i > -1; i--) {
								if (cellArr[i] is YuanJian) {
									targetYuanJian = cellArr[i] as YuanJian;
									break;
								}
							}
							if (targetYuanJian && !targetYuanJian.isKaKou &&  targetYuanJian.isOnGuiDao && targetYuanJian.topYuanJian == null) {
								targetYuanJian.topYuanJian = _dragingBitmap.yuanJian;
							} else {
								// 再判断是否能放到轨道上
								p.y -= 10;
								guiDao = null;
								cellArr = this.getObjectsUnderPoint(p);
								for (i = cellArr.length - 1; i > -1; i--) {
									if (cellArr[i] is GuiDao) {
										guiDao = cellArr[i] as GuiDao;
										break;
									}
								}
								if (guiDao) {
									guiDao.addYuanJian(_dragingBitmap.yuanJian, guiDao.globalToLocal(p));
								}
							}
						}
					}
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
		
		private function _onYuanJianQuInited(e:LayoutEvent):void {
			_buJuQu.initLayout(e.xml, e.layoutXML);
		}
	
	}

}
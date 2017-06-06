package view {
	import config.ConfigUtil;
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class MainScene extends Sprite {
		
		private var _buJuQu:BuJuQu;
		
		private var _yuanJianQu:YuanJianQu;
		
		private var _shuXingQu:ShuXingQu;
		
		private var _kongZhiQu:KongZhiQu;
		
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
			addChild(_yuanJianQu);
			
			_shuXingQu = new ShuXingQu(stageWidth >> 1, bottomPanelHeight, _buJuQu);
			_shuXingQu.y = stageHeight - bottomPanelHeight;
			addChild(_shuXingQu);
			
			_kongZhiQu = new KongZhiQu(stageWidth >> 1, bottomPanelHeight);
			_kongZhiQu.x = stageWidth >> 1;
			_kongZhiQu.y = stageHeight - bottomPanelHeight;
			_kongZhiQu.addEventListener(LayoutEvent.IMPORT_XML, _onImportXML);
			_kongZhiQu.addEventListener(LayoutEvent.ADD_GUI_DAO, _onAddGuiDao);
			_kongZhiQu.addEventListener(LayoutEvent.ADD_XIAN_CAO, _onAddXianCao);
			addChild(_kongZhiQu);
			
			this.addEventListener(MouseEvent.MOUSE_DOWN, _onMouseDown);
			this.addEventListener(MouseEvent.MOUSE_UP, _onMouseUp);
			this.addEventListener(MouseEvent.MOUSE_MOVE, _onMouseMoved);
		}
		private function _onAddXianCao(e:LayoutEvent):void {
			_buJuQu.addXianCao();
		}
		
		private function _onAddGuiDao(e:LayoutEvent):void {
			_buJuQu.addGuiDao();
		}
		
		private function _onImportXML(e:LayoutEvent):void {
			ConfigUtil.instance.loadXML();
		}
		
		private function _onMouseDown(e:MouseEvent):void {
			const cellArr:Array = this.getObjectsUnderPoint(new Point(e.stageX, e.stageY));
			trace(cellArr);
		}
		
		private function _onMouseUp(e:MouseEvent):void {
		
		}
		
		private function _onMouseMoved(e:MouseEvent):void {
		
		}
	
	}

}
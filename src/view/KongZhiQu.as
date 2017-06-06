package view {
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class KongZhiQu extends Sprite {
		
		
		
		public function KongZhiQu(width:int, height:int) {
			super();
			
			const g:Graphics = this.graphics;
			g.beginFill(0, 0);
			g.drawRect(0, 0, width, height);
			g.endFill();
		
			var btn:Sprite = _createBtn('载入元件');
			btn.y = (height - 30) >> 1;
			btn.addEventListener(MouseEvent.CLICK, _onImportXML);
			addChild(btn);
			
			btn = _createBtn('导出布局');
			btn.x = 100;
			btn.y = (height - 30) >> 1;
			btn.addEventListener(MouseEvent.CLICK, _onExportXML);
			addChild(btn);
			
			btn = _createBtn('增加线槽', 0x5b9bd5);
			btn.x = 200;
			btn.y = (height - 30) >> 1;
			btn.addEventListener(MouseEvent.CLICK, _onAddXianCao);
			addChild(btn);
			
			btn = _createBtn('增加轨道', 0xffc000);
			btn.x = 300;
			btn.y = (height - 30) >> 1;
			btn.addEventListener(MouseEvent.CLICK, _onAddGuiDao);
			addChild(btn);
		}
		
		private function _onAddGuiDao(e:MouseEvent):void {
			dispatchEvent(new LayoutEvent(LayoutEvent.ADD_GUI_DAO));
		}
		
		private function _onAddXianCao(e:MouseEvent):void {
			dispatchEvent(new LayoutEvent(LayoutEvent.ADD_XIAN_CAO));
		}
		
		private function _onExportXML(e:MouseEvent):void {
			trace('export');
		}
		
		private function _onImportXML(e:MouseEvent):void {
			this.dispatchEvent(new LayoutEvent(LayoutEvent.IMPORT_XML));
		}
		
		private function _createBtn(name:String, bgColor:int = 0x9dc3e6):Sprite {
			var btn:Sprite = new Sprite();
			const g:Graphics = btn.graphics;
			g.beginFill(bgColor);
			g.drawRect(0, 0, 60, 30);
			g.endFill();
			var tf:TextField = new TextField();
			tf.mouseEnabled = false;
			tf.text = name;
			tf.textColor = 0xffffff;
			tf.x = (60 - tf.textWidth) >> 1;
			tf.y = (30 - tf.textHeight) >> 1;
			tf.width = 60;
			tf.height = 30;
			btn.addChild(tf);
			return btn;
		}
	
	}

}
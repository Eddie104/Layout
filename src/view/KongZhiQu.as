package view {
	import events.LayoutEvent;
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.system.System;
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
			btn.x = 20;
			btn.y = (height - 30) >> 1;
			btn.addEventListener(MouseEvent.CLICK, _onImportXML);
			addChild(btn);
			
			btn = _createBtn('导出布局');
			btn.x = 100;
			btn.y = (height - 30) >> 1;
			btn.addEventListener(MouseEvent.CLICK, _onExportXML);
			addChild(btn);
		
			//btn = _createBtn('增加线槽', 0x5b9bd5);
			//btn.x = 160;
			//btn.y = (height - 30) >> 1;
			//btn.addEventListener(MouseEvent.CLICK, _onAddXianCao);
			//addChild(btn);
			//
			//btn = _createBtn('增加轨道', 0xffc000);
			//btn.x = 240;
			//btn.y = (height - 30) >> 1;
			//btn.addEventListener(MouseEvent.CLICK, _onAddGuiDao);
			//addChild(btn);
			//
			//btn = _createBtn('虚拟轨道', 0xffc000);
			//btn.x = 320;
			//btn.y = (height - 30) >> 1;
			//btn.addEventListener(MouseEvent.CLICK, _onAddJiaGuiDao);
			//addChild(btn);
		}
		
		//private function _onAddJiaGuiDao(e:MouseEvent):void {
		//dispatchEvent(new LayoutEvent(LayoutEvent.ADD_JIA_GUI_DAO));
		//}
		
		//private function _onAddGuiDao(e:MouseEvent):void {
		//dispatchEvent(new LayoutEvent(LayoutEvent.ADD_GUI_DAO));
		//}
		
		//private function _onAddXianCao(e:MouseEvent):void {
		//dispatchEvent(new LayoutEvent(LayoutEvent.ADD_XIAN_CAO));
		//}
		
		private function _onExportXML(e:MouseEvent):void {
			//trace('export');
			
			/*
			<?xml version="1.0" encoding="UTF-8"?>
			<Layout>
			<TRUNKING NAME="Trunk_0001" SIZE="800,10" START="0,0" END= "0,800" />
			<TRUNKING NAME="Trunk_0002" SIZE="800,10" START="500,0" END= "500,800" />
			<TRUNKING NAME="Trunk_0003" SIZE="500,10" START="0,800" END= "500,800" />
			<TRUNKING NAME="Trunk_0004" SIZE="500,10" START="0,600" END= "500,600" />
			<TRUNKING NAME="Trunk_0005" SIZE="500,10" START="0,350" END= "500,350" />
			<TRUNKING NAME="Trunk_0006" SIZE="500,10" START="0,0" END= "500,500" />
			<PATHWAY NAME="Path_0001" SIZE="460,10" START="20,700" END= "480,700" />
			<PATHWAY NAME="Path_0002" SIZE="460,10" START="20,470" END= "480,470" />
			<PATHWAY NAME="Path_0003" SIZE="400,10" START="20,175" END= "420,175" />
			</Layout>
			<DATA>
			<ITEM NAME="DK01" PATHWAY="Path_0001" POS="150,700"/>
			<ITEM NAME="DK02" PATHWAY="Path_0001" POS="250,700"/>
			<ITEM NAME="TD05" PATHWAY="Path_0001" POS="350,700"/>
			<ITEM NAME="TD06" PATHWAY="Path_0002" POS="120,470"/>
			<ITEM NAME="HK01" PATHWAY="Path_0002" POS="200,470"/>
			<ITEM NAME="HK02" PATHWAY="Path_0002" POS="250,470"/>
			<ITEM NAME="HK03" PATHWAY="Path_0002" POS="300,470"/>
			<ITEM NAME="BD08" PATHWAY="" POS="190,175"/>
			<ITEM NAME="HK04" PATHWAY="" POS="280,175"/>
			<ITEM NAME="DH01" PATHWAY="" POS="440,175"/>
			</DATA>
			*/
			var bujuQu:BuJuQu = Main.mainScene.buJuQu;
			
			var xmlStr:String = '<?xml version="1.0" encoding="UTF-8"?>\n<data>\n\t<layout>\n';
			xmlStr += bujuQu.exportXianCao() + bujuQu.exportGuiDao() + '\n\t</layout>';
			xmlStr += '\n\t<items>' + bujuQu.exportYuanJian() + '\n\t</items>';
			xmlStr += '\n</data>';
			trace(xmlStr);
			System.setClipboard(xmlStr);
		}
		
		private function _onImportXML(e:MouseEvent):void {
			this.dispatchEvent(new LayoutEvent(LayoutEvent.IMPORT_XML));
		}
		
		private function _createBtn(name:String, bgColor:int = 0x9dc3e6, w:int = 60):Sprite {
			var btn:Sprite = new Sprite();
			const g:Graphics = btn.graphics;
			g.beginFill(bgColor);
			g.drawRect(0, 0, w, 30);
			g.endFill();
			var tf:TextField = new TextField();
			tf.mouseEnabled = false;
			tf.text = name;
			tf.textColor = 0xffffff;
			tf.x = (w - tf.textWidth) >> 1;
			tf.y = (30 - tf.textHeight) >> 1;
			tf.width = w;
			tf.height = 30;
			btn.addChild(tf);
			return btn;
		}
	
	}

}
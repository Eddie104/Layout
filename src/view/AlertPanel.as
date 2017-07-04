package view {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public final class AlertPanel extends Sprite {
		
		private var _tf:TextField;
		
		private var _yesBtn:Sprite;
		
		private var _cancelBtn:Sprite;
		
		public function AlertPanel(content:String) {
			super();
			_tf = new TextField();
			_tf.mouseEnabled = false;
			_tf.text = content;
			_tf.textColor = 0xffffff;
			addChild(_tf);
			
			_yesBtn = _createBtn(0xff0000, '删除');
			_yesBtn.addEventListener(MouseEvent.CLICK, _onYes);
			addChild(_yesBtn);
			
			_cancelBtn = _createBtn(0x0000ff, '取消');
			_cancelBtn.addEventListener(MouseEvent.CLICK, _onNo);
			addChild(_cancelBtn);
		}
		
		private function _onYes(e:MouseEvent):void {
			
		}
		
		private function _onNo(e:MouseEvent):void {
			
		}
		
		private function _createBtn(color:int, content:String):Sprite {
			const btn:Sprite = new Sprite();
			btn.graphics.beginFill(color);
			btn.graphics.drawRect(0, 0, 60, 30);
			btn.graphics.endFill();
			const tf:TextField = new TextField();
			tf.mouseEnabled = false;
			tf.text = content;
			tf.textColor = 0xffffff;
			tf.x = (60 - tf.textWidth) >> 1;
			tf.y = (30 - tf.textHeight) >> 1;
			btn.addChild(tf);
			return btn;
		}
		
		public function show(stage:Stage):void {
			const g:Graphics = this.graphics;
			g.beginFill(0, 0);
			g.drawRect(0, 0, stage.stageWidth, stage.stageHeight);
			g.endFill();
			g.beginFill(0x363636);
			g.drawRect((stage.stageWidth - 200) >> 1, (stage.stageHeight - 80) >> 1, 200, 80);
			g.endFill();
			
			_tf.x = (stage.stageWidth - _tf.textWidth) >> 1;
			_tf.y = ((stage.stageHeight - _tf.textHeight) >> 1) - 20;
			
			_yesBtn.x = (stage.stageWidth >> 1) - 80;
			_yesBtn.y = stage.stageHeight >> 1;
			
			_cancelBtn.x = (stage.stageWidth >> 1) + 20;
			_cancelBtn.y = stage.stageHeight >> 1;
			
			stage.addChild(this);
		}
	
	}

}
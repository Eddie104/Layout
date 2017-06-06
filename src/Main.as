package {
	import flash.display.Sprite;
	import flash.events.Event;
	import view.MainScene;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class Main extends Sprite {
		
		private var _mainScene:MainScene;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			//stage.scaleMode = StageScaleMode.EXACT_FIT;
			//this.stage.addEventListener(Event.RESIZE, _noResize);
			
			_mainScene = new MainScene(this.stage.stageWidth, this.stage.stageHeight);
			addChild(_mainScene);
		}
		
		//private function _noResize(evt:Event):void {
			//trace("as");
		//}
	}

}
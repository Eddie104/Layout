package {
	import flash.display.Sprite;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.net.FileReference;
	import flash.net.SharedObject;
	import view.MainScene;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class Main extends Sprite {
		
		public static var mainScene:MainScene;
		
		public function Main() {
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void {
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			stage.scaleMode = StageScaleMode.NO_SCALE;
			//this.stage.addEventListener(Event.RESIZE, _noResize);
			
			mainScene = new MainScene(this.stage.stageWidth, this.stage.stageHeight);
			addChild(mainScene);
			
			
			//var fileRef:FileReference = new FileReference();
			//fileRef.save('test', "wenben.txt");
		}
		
		//private function _noResize(evt:Event):void {
			//trace("as");
		//}
	}

}
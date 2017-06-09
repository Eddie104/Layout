package model {
	import flash.display.Graphics;
	import flash.display.Sprite;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author hongjie
	 */
	public class Cell extends Sprite {
		
		public static const FILTER:Array = [new GlowFilter(0xff0000)];
		
		protected var _w:int;
		
		protected var _h:int;
		
		protected var _bgColor:int;
		
		protected var _isSelected:Boolean;
		
		protected var _nameTF:TextField = new TextField();
		
		public function Cell(width:int, height:int, bgColor:int) {
			super();
			this._bgColor = bgColor;
			this.setSize(width, height);
			_nameTF.mouseEnabled = false;
			_nameTF.width = width;
			_nameTF.height = height;
			_nameTF.textColor = 0xffffff;
			_nameTF.multiline = true;
			_nameTF.wordWrap = true;
			addChild(_nameTF);
		}
		
		public function setSize(w:int, h:int = -1):void {
			if (w > -1)
				this._w = w;
			if (h > -1)
				this._h = h;
			this._drawBorder();
		}
		
		protected function _drawBorder():void {
			const g:Graphics = this.graphics;
			g.clear();
			g.lineStyle(1);
			g.moveTo(0, 0);
			g.lineTo(this._w - 1, 0);
			g.lineTo(this._w - 1, this._h);
			g.lineTo(0, this._h);
			g.lineTo(0, 0);
			g.beginFill(_bgColor);
			g.drawRect(0, 0, _w, _h);
			g.endFill();
		}
		
		public function get isSelected():Boolean {
			return this._isSelected;
		}
		
		public function set isSelected(val:Boolean):void {
			this._isSelected = val;
			this.filters = val ? FILTER : null;
		}
		
		public function get reallyWidth():int {
			return _w;
		}
		
		public function get reallyHeight():int {
			return _h;
		}
		
		override public function get name():String {
			return super.name;
		}
		
		override public function set name(value:String):void {
			super.name = value;
			this._nameTF.text = value;
			_nameTF.x = (_w - _nameTF.textWidth) >> 1;
			_nameTF.y = (_h - _nameTF.textHeight) >> 1;
		}
	
	}

}
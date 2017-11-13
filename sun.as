package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
import flash.events.MouseEvent;
	
	
	public class sun extends MovieClip {
		private var  sun_x:int;
		private var	 end_y:int;
		var sunTimer:Timer;
		var timeEnd:int;
		var ready:Boolean=false;
		
		public function sun() {
			// constructor code
			timeEnd=0;
			this.sun_x=randRange(250,1000);
			this.end_y=randRange(100,500);
			this.x=this.sun_x;
			this.y=-20;
			sunTimer = new Timer(41);//定时器
			sunTimer.start();
			sunTimer.addEventListener(TimerEvent.TIMER,serves);
			this.addEventListener(MouseEvent.MOUSE_DOWN,getSun);
		}
		function randRange(minNum:Number, maxNum:Number):Number 
        {
            return (Math.floor(Math.random() * (maxNum - minNum + 1)) + minNum);
        }
		public function getSun(e:Event):void{
			this.ready=true;
		}
		public function init(){
			
			
		}
		
		public function _move(){
			if(ready){
				if(this,x>0) this.x=this.x-5;
				if(this.x>0) this.y=this.y-5;
				if(this.x<=0&&this.y<=0){
					destroy();
				}
			}else{
				if(this.y<this.end_y){
					this.y=this.y+2;
				}
				
			}
			
		
		
		}
		public function serves(event:Event){
			_move();
		}
		public function destroy():void{
			sunTimer.stop();
			sunTimer.removeEventListener(TimerEvent.TIMER,serves);
			this.removeEventListener(MouseEvent.MOUSE_DOWN,getSun);
			this.visible=false;
			if(parent!=null) parent.removeChild(this);
			
			
		} 
		
		
		
	}
	
}

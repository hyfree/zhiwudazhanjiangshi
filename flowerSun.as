package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
import flash.events.MouseEvent;
	
	
	public class flowerSun extends MovieClip {
		var ready:Boolean=false;
		var sunTimer:Timer;
		
		public function flowerSun() {
			// constructor code
			sunTimer = new Timer(41);//定时器
			sunTimer.start();
			sunTimer.addEventListener(TimerEvent.TIMER,serves);
			this.addEventListener(MouseEvent.MOUSE_DOWN,getSun);
		}
		public function getSun(e:Event):void{
			this.ready=true;
		}
		public function _move(){
			if(ready){
				if(this,x>-20) this.x=this.x-5;
				if(this.y>-20) this.y=this.y-5;
				if(this.x<=0||this.y<=0){
					destroy();
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

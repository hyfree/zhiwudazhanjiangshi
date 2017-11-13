package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;

	public class Zombie extends MovieClip {
		private var hp:int;//血量
		private var speed:int;//移动速度
		private var status:int;//定义僵尸的状态
		private var zomTimer:Timer;
		//set and get
		//定义僵尸的行为
		public function Zombie() {
		//初始化代码
		init();
		}
		public function attack():void{
			
		}
		public function lostHead():void{
		
		}
		public function goForward():void{
			this.x=this.x-1;
			if(this.x<-20)
				destroy();
		}
		//僵尸的生命周期
		public function init():void{
			zomTimer = new Timer(41);//定时器
			zomTimer.start();
			zomTimer.addEventListener(TimerEvent.TIMER,serves);
		}
		function serves(event:Event){
			goForward();
			
		}
		public function destroy():void{
			zomTimer.stop();
			zomTimer.removeEventListener(TimerEvent.TIMER,serves);
			this.visible=false;
			if(parent!=null) parent.removeChild(this);
			
		} 
			
		
	}
	
}

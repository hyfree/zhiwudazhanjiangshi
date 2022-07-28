package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
	
	
	public class PB00 extends MovieClip {
		
		private var speed:int;//豌豆的速度
		private var power:int;//伤害
		private var distance:int;//射击距离
		private var end_x:int;//豌豆消失的位置
		var pbTimer:Timer;
		//构造函数
		public function PB00() {
			// 初始化植物设计参数
			this.speed=1;
			this.power=1;
			//初始化自动行为
			pbTimer = new Timer(41);//定时器
			pbTimer.start();
			pbTimer.addEventListener(TimerEvent.TIMER,serves);
			
		}
		//set and get
		public function setEnd_x(end:int):void{
			this.end_x=end;
		}
		public function getEnd_x():int{
			return this.end_x;
		}
		//定义的行为
		public function attack():void{
			
		}
		public function lostHead():void{
		
		}
		public function goForward():void{
			
				this.x=this.x+4;
			
		}
		//植物的生命周期
		public function init():void{
			
			
		}
		function serves(event:Event){
			
			goForward();
		}
		public function destroy():void{
			pbTimer.stop();
			pbTimer.removeEventListener(TimerEvent.TIMER,serves);
			this.visible=false;
			if(parent!=null) parent.removeChild(this);
			
			
		} 
	}
	
}

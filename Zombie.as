﻿package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;

	public class Zombie extends MovieClip {
		private var hp:int;//血量
		private var speed:int;//移动速度
		private var status:int;//定义僵尸的状态
		private var zomTimer:Timer;
		private var it;
		//set and get
		public function setHp(myHp:int):void{
			this.hp=myHp;
		}
		public function getHp():int{
			return this.hp;
		}
		public function setStatus(sta:int){
			this.status=sta;
			
		}
		public function getStatus():int{
			return this.status;
		}
		public function getIt():int{
			return this.it;
		}
		public function setIt(myIt:int):void{
			this.it=myIt;
			
		}
		
		
		
		//构造函数，定义僵尸的行为
		public function Zombie() {
			
			//初始化代码
			init();
		}
		
		public function hit():void{
			this.hp=this.hp-1;
		}
		public function attack():void{
			
		}
		public function lostHead():void{
		
		}
		public function goForward():void{
			this.x=this.x-2;
			
		}
		//僵尸的生命周期
		public function init():void{
			this.status=1;
			this.hp=5;
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

package  {
	
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
import flash.display.DisplayObject;
	
	
	public class SunFlower extends MovieClip {
		private var hp:int;
		
		public function SunFlower() {
			
			// constructor code
			this.hp=3;//默认血量为3
			//mainTimer= new Timer(3);//定时器
			//mainTimer.start();
			//mainTimer.addEventListener(TimerEvent.TIMER,serves);
		}
		
		//get and set
		public function setHp(myHP:int):void{
			this.hp=myHP;
		}
		public function getHp():int{
			return this.hp;
		}
		public function hit():void{
			this.hp=this.hp-1;
		}
		//植物的生命周期
		public  function init():void{
			
		}
		function serves(event:Event){
			
		}
		public function destroy():void{
			//PlaTimer.stop();
			//PlaTimer.removeEventListener(TimerEvent.TIMER,serves);
			this.visible=false;
			if(parent!=null) parent.removeChild(this);
		} 
		
		
		
		
		
	}
	
}

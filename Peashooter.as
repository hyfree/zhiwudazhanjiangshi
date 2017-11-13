package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
	
	
	public class Peashooter extends MovieClip {
		private var hp:int;//血量
		private var speed:int;//射击速度
		private var status:int;//定义植物的状态
		var PlaTimer:Timer;
		private var PBs:Array=new Array();
		public function Peashooter() {
			// constructor code
			this.status=0;
			PlaTimer= new Timer(41);//定时器
			PlaTimer.start();
			PlaTimer.addEventListener(TimerEvent.TIMER,serves);
		}
		
		
		//set and get
		//定义的行为
		public function attack():void{
			var pb:PB00=new PB00();
			pb.set(this.x+500);//涉及子弹的射程
			pb.x=this.x+20;
			pb.y=this.y;
			pb.visible=true;
			parent.addChild(pb);
			PBs.push(pb);
			
		}
		//植物的生命周期
		public  function init():void{
			
		}
		function serves(event:Event){
			status++;
			var sta=status%50;
			if (sta==0){
				status=0;
				attack();
				}			
				
			
		}
		public function destroy():void{
			PlaTimer.stop();
			PlaTimer.removeEventListener(TimerEvent.TIMER,serves);
			this.visible=false;
			if(parent!=null) parent.removeChild(this);
		} 
			
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
	}
	
}

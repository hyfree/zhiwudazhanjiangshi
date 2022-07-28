package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
import flash.display.DisplayObject;
	
	
	public class Peashooter extends MovieClip {
		private var hp:int;//血量
		private var status:int;//定义植物的状态
		
		//构造函数
		public function Peashooter(){
			// constructor code
			this.hp=3;//默认血量为3
			this.status=0;
		}
		/*set and set*/
		public function setHp(myHP:int):void{
			this.hp=myHP;
		}
		public function getHp():int{
			return this.hp;
		}
		public function setStatus(myStatus:int):void{
			this.status=myStatus;
		}
		public function getStatus():int{
			return this.status;
		}
		
		
		public function hit():void{
			this.hp=this.hp-1;
		}
		public function getType():String{
			return "Peashooter";
		}
		
		
		//植物的生命周期
		public  function init():void{
			
		}
		function serves(event:Event){
			
		}
		public function destroy():void{
			this.visible=false;
			if(parent!=null) parent.removeChild(this);
		} 

		
		
		
	}
	
}

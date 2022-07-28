package  {
	
	import flash.display.MovieClip;
	
	
	public class LawnMower extends MovieClip {
		private var isHit:Boolean;//是否已经发生碰撞，默认为false
		
		public function LawnMower() {
			// constructor code
			this.isHit=false;
		}
		//get and set
		public function getIsHit():Boolean{
			return this.isHit;
		}
		public function setIsHit(hit:Boolean):void{
			this.isHit=hit;
		}
		
		public function destroy():void{
			trace("推土机被销毁");
			this.visible=false;
			if(parent!=null) parent.removeChild(this);
			
		} 
		
		
		
	}
	
}

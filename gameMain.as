package  {
import flash.display.MovieClip;
import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.Event;
import flash.media.Sound;
import flash.ui.Mouse;
import flash.events.MouseEvent;
import flash.ui.ContextMenu;
import flash.events.ContextMenuEvent;
	
	public class gameMain extends MovieClip {
		var Zombies:Array=new Array();//储存僵尸
		var Plas:Array=new Array();//储存植物
		var status:Array=new Array();//储存每条道路的状态
		var Suns:Array=new Array();//储存阳光对象的数组
		var mousePicture:Peashooter;//鼠标形状
		var _selected:Boolean=false;//选择状态
		var sunNumber:int=1000;//玩家拥有的阳光
		var step:int=0;
		public function gameMain() {

			//初始化游戏参数
			this.sunNumber=1000;
			for(var i:int=1;i<=5;i++){
				Zombies[i]=new Array();
				Plas[i]=new Array();
				status[i]=false;
			}
			//初始化游戏音乐
			var mc:BgMusic=new BgMusic();
			mc.play();
			//初始化游戏主定时器
			var gameTimer:Timer = new Timer(41);//定时器
			gameTimer.start();
			gameTimer.addEventListener(TimerEvent.TIMER,serves);
			
			
			
			this.addEventListener(MouseEvent.MOUSE_MOVE,_mouseMove);//侦听鼠标移动
			bg.addEventListener(MouseEvent.MOUSE_DOWN,_mouseDown);//侦听bg鼠标按下
			PSC.addEventListener(MouseEvent.MOUSE_DOWN,_PSC_mouseDown);//侦听PSC鼠标按下
		}
		
		//侦听PSC鼠标按下
		function _PSC_mouseDown(e:Event):void
		{
			if(_selected){
				Mouse.show();
				mousePicture.destroy();
				_selected=false;
				
			}else{
				if(sunNumber-100>=0){
					Mouse.hide();
					mousePicture=new Peashooter();
					mousePicture.visible=true;
					this.addChild(mousePicture);
					mousePicture.x=mouseX;
					mousePicture.y=mouseY;
					_selected=true;
				}
				
				
				
			}
			
		}
		//侦听鼠标移动
		function _mouseMove(e:Event):void
		{
			if(_selected){
				mousePicture.x=mouseX;
				mousePicture.y=mouseY;
			}
			
		}
		//侦听鼠标按下
		function _mouseDown(e:Event):void
		{
			//trace("x="+mouseX+"y="+mouseY);
			if(_selected&&this.sunNumber>=100){
				//位置
				var Dx:int=mouseX+30;
				var Dy:int=mouseY+71;
				//是否在种植区域
				if(Dx>260&&Dy>100&&Dx<1000&&Dy<570){
					//判断种植的方格
					for(var x:int=0;x<=8;x++){
						for(var y:int=0;y<=4;y++){
							if(Dx>(260+80*x)&&Dx<(260+80*(x+1))&&Dy>(100+100*y)&&Dy<(100+100*(y+1)) ){
								//Row  行
								//Column列
								var row:int=y+1;
								var column:int=x+1;
								//trace(Dx+"-"+Dy)
								//trace("r="+row+"c="+column);
								if(Plas[row][column]==null){
									var pla:Peashooter=new Peashooter();
								pla.x=260+80*x;
								pla.y=100+100*y;
								pla.visible=true;
								this.addChild(pla);
								Plas[row][column]=pla;
								this.sunNumber=this.sunNumber-100;
								sunText.text="阳光="+this.sunNumber;
								trace(this.sunNumber);
									}
								
								break;
							}
						}
					}//判断种植的方格
					
				}//是否在种植区域
			}//判断选择状态
		}//方法结束
		
		//种植植物
		public function newPla(){
				var mySun:sun=new sun();
				mySun.visible=true;
			this.addChild(mySun);
				
		}
		
		//生产僵尸
		public function newZombie(){
			var zom:Zombie=new Zombie();
			var rand:int=(Math.floor(Math.random() * 5 + 1));
			zom.y=20+100*(rand-1);
			zom.x=1200;
			zom.visible=true;
			this.addChild(zom);
			Zombies[rand].push(zom);
			status[rand]=true;
			
		}
		//生成阳光
		public function newSun(){
				var mySun:sun=new sun();
				mySun.visible=true;
				mySun.addEventListener(MouseEvent.MOUSE_DOWN,getSun);
			this.addChild(mySun);
				
		}
		public function getSun(e:Event){
			this.sunNumber=this.sunNumber+100;
			
			}
		public function serves(event:Event){
			sunText.text="阳光="+sunNumber;
			step++;
			if(step%300==0){
				newZombie();
				newSun();
				}
				
			if(step==1000)
				step=0;
			
			
		}
	}
}
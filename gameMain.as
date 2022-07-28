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
import flash.display.DisplayObject;

	/*********************************************************************************
	***植物大战僵尸 beta1.0
	***作者：wxq
	***完成：2017-11-14
	***修改：？
	***********************************************************************************
	*/
	public class gameMain extends MovieClip {//class
		var Zombies:Array=new Array();//储存僵尸
		var Cars:Array=new Array();//储存推草车
		var Plants:Array=new Array();//储存全局植物
		var Plas:Array=new Array();//储存豌豆射手植物
		var sunFlowers:Array=new Array();//储存向日葵
		var PBs:Array=new Array();//储存子弹
		var PB_distance:int=400;//子弹射程
		var status:Array=new Array();//储存每条道路的状态
		var Suns:Array=new Array();//储存阳光对象的数组
		var mousePicture:DisplayObject;//鼠标形状
		var newMousePicture:DisplayObject;//新的鼠标形状
		var _selected:Boolean=false;//选择状态
		var _selected_item:String="0";//选择的卡片
		var _selected_NewItem:String="0";//新选择的卡片
		var sunNumber:int;//玩家开始游戏前拥有的阳光
		var playerScore:int=0;//玩家开启阶段拥有的得分
		//杀死一个僵尸，获得10分，失去一个植物惩罚50分
		var dead:Array=new Array();
		var step:int=0;
		
		
		
		//构造函数
		public function gameMain() {
			var plsa:Peashooter=new Peashooter();
		/*********************************************************************************
		***游戏初始化管理器
		*/
			//初始化游戏场景
			alertTest.visible=false;
			GameOver.visible=false;
			//初始化游戏参数
			this.sunNumber=500;
			for(var i:int=1;i<=5;i++){
				//Cars[i]=new Array();
				PBs[i]=new Array();
				Zombies[i]=new Array();
				Plas[i]=new Array();
				sunFlowers[i]=new Array();//向日葵
				status[i]=false;
			}
			Cars[1]=car1;
			Cars[2]=car2;
			Cars[3]=car3;
			Cars[4]=car4;
			Cars[5]=car5;
			
			//初始化游戏音乐
			var mc:BgMusic=new BgMusic();
			mc.play();
			/*******************************************************************
			***初始化游戏定时器
			*/
			//初始化游戏游戏服务调度定时器
			var gameTimer:Timer = new Timer(41);//定时器
			gameTimer.start();
			gameTimer.addEventListener(TimerEvent.TIMER,serves);
			//豌豆产生定时器
			var PbTimer:Timer = new Timer(3000);//定时器
			PbTimer.start();
			PbTimer.addEventListener(TimerEvent.TIMER,newPB);
			//太阳产生定时器
			var sunTimer:Timer = new Timer(10000);//定时器
			sunTimer.start();
			sunTimer.addEventListener(TimerEvent.TIMER,newSun);
			//僵尸产生定时器
			var zomTimer:Timer = new Timer(5000);//定时器
			zomTimer.start();
			zomTimer.addEventListener(TimerEvent.TIMER,newZombie);
			//向日葵定时器
			var sunFlowerTimer:Timer = new Timer(10000);//定时器
			sunFlowerTimer.start();
			sunFlowerTimer.addEventListener(TimerEvent.TIMER,newFlowerSun);
			//僵尸攻击定时器
			var zomAttackTimer:Timer = new Timer(2000);//定时器
			zomAttackTimer.start();
			zomAttackTimer.addEventListener(TimerEvent.TIMER,ZombieEat);
			/*******************************************************************
			***初始化游戏鼠标监听器
			*/
			this.addEventListener(MouseEvent.MOUSE_MOVE,_mouseMove);//侦听鼠标移动
			bg.addEventListener(MouseEvent.MOUSE_DOWN,_mouseDown);//侦听bg鼠标按下
			PeashooterCard.addEventListener(MouseEvent.MOUSE_DOWN,PeashooterDown);//侦听豌豆射手鼠标按下
			PotatoMineCard.addEventListener(MouseEvent.MOUSE_DOWN,PotatoMineDown);//侦听土豆地雷鼠标按下
			PumpkinHeadCard.addEventListener(MouseEvent.MOUSE_DOWN,PumpkinHeadDown);//侦听南瓜头鼠标按下
			SunFloweCard.addEventListener(MouseEvent.MOUSE_DOWN,sunflowerDown);//侦听向日葵鼠标按下
			TwinSunflowerCard.addEventListener(MouseEvent.MOUSE_DOWN,TwinSunflowerDown);//侦听姐妹向日葵鼠标按下
			WallNutCard.addEventListener(MouseEvent.MOUSE_DOWN,WallNutDown);//侦听坚果鼠标按下

		}
		/*********************************************************************************
		***游戏资源管理器
		*/
		public function newPla(){
				var mySun:sun=new sun();
				mySun.visible=true;
			this.addChild(mySun);
				
		}
		//生产僵尸
		public function newZombie(e:Event){
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
		public function newSun(e:Event){
				var mySun:sun=new sun();
				mySun.visible=true;
				mySun.addEventListener(MouseEvent.MOUSE_DOWN,getSun);
			this.addChild(mySun);
				
		}
		//太阳花生产太阳
		public function newFlowerSun(e:Event){
			for(var c:int=1;c<=5;c++){
				for(var su:int=0;su<sunFlowers[c].length;su++){
					var sun:flowerSun=new flowerSun();
					sun.x=sunFlowers[c][su].x;
					sun.y=sunFlowers[c][su].y;
					sun.visible=true;
					this.addChild(sun);
					sun.addEventListener(MouseEvent.MOUSE_DOWN,getSun);
				}
				
			}
			
		}
		//获取阳光
		public function getSun(e:Event){
			this.sunNumber=this.sunNumber+100;
		}
		public function isGameOver():void{
			for(var c:int=1;c<=5;c++){
				for(var i:int=0;i<Zombies[c].length;i++){
					if(Zombies[c][i].x<=0){
						GameOver.visible=true;
						
					}
					
					
				}
				
			}
			
		}
		/*********************************************************************************
		***僵尸对象管理器
		*/
		//僵尸越界约束器，将越界的僵尸销毁
		public function  ZomOutOfBounds():void{
			for(var c:int=1;c<=5;c++){
				for(var i:int=0;i<Zombies[c].length;i++){//for
					if(Zombies[c][i].x<-50){//if
						Zombies[c][i].destroy();
						Zombies[c].splice(i,1);
						GameOver.visible=true;
						
					}//if
				}//for
				
				
			}
			
		
		}//out
		//僵尸前进转换器
		public function ZomGo():void{
			for(var c:int=1;c<=5;c++){
				for(var zom:int=0;zom<Zombies[c].length;zom++){
					if(Zombies[c][zom].getStatus()==2){
						var ishit=false;
						for(var pla:int=0;pla<Plas[c].length;pla++){//for:pla
							if(Zombies[c][zom].x<(Plas[c][pla].x-20)&&(Zombies[c][zom].x+70)>(Plas[c][pla].x-20)){//if:zom
								ishit=true;
							}//if:zom
						}//for:pla
						//循环太阳花
						for(var sun:int=0;sun<sunFlowers[c].length;sun++){//for:pla
							if(Zombies[c][zom].x<(sunFlowers[c][sun].x-20)&&(Zombies[c][zom].x+70)>(sunFlowers[c][sun].x-20)){//if:zom
								ishit=true;
							 }
						}//for:pla
						if(ishit){
							
							
						}else{
							var simZom:Zombie=new Zombie();
							simZom.x=Zombies[c][zom].x;
							simZom.y=Zombies[c][zom].y;
							simZom.setHp(Zombies[c][zom].getHp());
							Zombies[c][zom].destroy();
							simZom.visible=true;
							this.addChild(simZom);
							Zombies[c][zom]=simZom;
							
						}
						
						
						
					}
					
				}
				
			}
			
		}
		
		
		
		//僵尸状态转换器
		public function ZomAttack():void{
			for(var c:int=1;c<=5;c++){//for:c
				for(var zom:int=0;zom<Zombies[c].length;zom++){//for:zom
					for(var pla:int=0;pla<Plas[c].length;pla++){//for:pla
						if(Zombies[c][zom].x<(Plas[c][pla].x-20)&&(Zombies[c][zom].x+70)>(Plas[c][pla].x-20)){//if:zom
						
							if(Zombies[c][zom].getStatus()==1){
								var attack:ZombieAttack=new ZombieAttack();
								attack.x=Zombies[c][zom].x;
								attack.y=Zombies[c][zom].y;
								attack.setIt(Plas[c][pla].x);
								attack.setHp(Zombies[c][zom].getHp());
								Zombies[c][zom].destroy();
								attack.visible=true;
								this.addChild(attack);
								Zombies[c][zom]=attack;
								
							}//if:status
							
							
							/*Zombies[c][zom].hit();
							PBs[c][pb].destroy();
							PBs[c].splice(pb,1);*/
							}//if:zom
					}//for:pla
					//循环太阳花
					for(var sun:int=0;sun<sunFlowers[c].length;sun++){//for:pla
						if(Zombies[c][zom].x<(sunFlowers[c][sun].x-20)&&(Zombies[c][zom].x+70)>(sunFlowers[c][sun].x-20)){//if:zom
							if(Zombies[c][zom].getStatus()==1){
								var newattack:ZombieAttack=new ZombieAttack();
								trace(newattack.getStatus());
								newattack.x=Zombies[c][zom].x;
								newattack.y=Zombies[c][zom].y;
								newattack.setIt(sunFlowers[c][sun].x);
								newattack.setHp(Zombies[c][zom].getHp());
								Zombies[c][zom].destroy();
								newattack.visible=true;
								this.addChild(newattack);
								Zombies[c][zom]=newattack;
								
							}//if:status
						 }else{
							if(Zombies[c][zom].getStatus()==2){
								
								
							}
							 
						}
								
					   
					}//for:pla
						
					
					
					
					
				}//for:zom
					
				
				
				
			}//for:c
			
			
		}//function
		//僵尸攻击协调器
		public function ZombieEat(e:Event):void{
			for(var c:int=1;c<=5;c++){//for:c
				for(var zom:int=0;zom<Zombies[c].length;zom++){//for:zom
					var isAttack:Boolean=false;
					for(var pla:int=0;pla<Plas[c].length;pla++){//for:pla
						if(Zombies[c][zom].x<(Plas[c][pla].x-20)&&(Zombies[c][zom].x+70)>(Plas[c][pla].x-20)){//if
							if(Zombies[c][zom].getStatus()==2){//if(Zombies[c][zom].getStatus()==2){
								
								Plas[c][pla].hit();
								if(Plas[c][pla].getHp()<=0){//if(PLas...)
									
									this.playerScore-=20;//惩罚20分
									Plas[c][pla].destroy();
									Plas[c].splice(pla,1)
									var simZom:Zombie=new Zombie();
									simZom.x=Zombies[c][zom].x;
									simZom.y=Zombies[c][zom].y;
									simZom.setHp(Zombies[c][zom].getHp());
									Zombies[c][zom].destroy();
									simZom.visible=true;
									this.addChild(simZom);
									Zombies[c][zom]=simZom;
								}//if(PLas...)
							}//if(Zombies[c][zom].getStatus()==2){
								/*Zombies[c][zom].hit();
								PBs[c][pb].destroy();
								PBs[c].splice(pb,1);*/
							}//if
						}//for:pla
						//向日葵
						for(var sun:int=0;sun<sunFlowers[c].length;sun++){//for:pla
						if(Zombies[c][zom].x<(sunFlowers[c][sun].x-20)&&(Zombies[c][zom].x+70)>(sunFlowers[c][sun].x-20)){//if
							if(Zombies[c][zom].getStatus()==2){//if(Zombies[c][zom].getStatus()==2){
							
								sunFlowers[c][sun].hit();
								if(sunFlowers[c][sun].getHp()<=0){//if(PLas...)
									trace("植物被销毁");
									
									this.playerScore-=20;//惩罚20分
									sunFlowers[c][sun].destroy();
									sunFlowers[c].splice(sun,1)
									
									var newsimZom:Zombie=new Zombie();
									newsimZom.x=Zombies[c][zom].x;
									newsimZom.y=Zombies[c][zom].y;
									
									newsimZom.setHp(Zombies[c][zom].getHp());
									Zombies[c][zom].destroy();
									newsimZom.visible=true;
									this.addChild(newsimZom);
									Zombies[c][zom]=newsimZom;
								}//if(PLas...)
							}//if(Zombies[c][zom].getStatus()==2){
								/*Zombies[c][zom].hit();
								PBs[c][pb].destroy();
								PBs[c].splice(pb,1);*/
							}//if
						}//for:pla
					}//for:zom

			}//for:c
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
			
		}
		/*********************************************************************************
		***豌豆管理器
		*/
		
		//豌豆产生器
		public function newPB(e:Event):void{
			for(var i:int =1;i<=5;i++){
				for(var m:int =0;m<Plas[i].length;m++){
					var pb:PB00=new PB00();
					pb.setEnd_x(Plas[i][m].x+PB_distance);//涉及子弹的射程
					pb.x=Plas[i][m].x+20;
					pb.y=Plas[i][m].y;
					pb.visible=true;
					this.addChild(pb);
					PBs[i].push(pb);
				}
			}
			
			
		}
		//植物遭到攻击
		public function PlaHit():void{
			
		}
		//越界约束器，将越界的豌豆销毁
		public function  OutOfBounds():void{
			for(var c:int=1;c<=5;c++){
				for(var i:int=0;i<PBs[c].length;i++){//for
					if(PBs[c][i].x>1000||PBs[c][i].x>PBs[c][i].getEnd_x()){//if
						PBs[c][i].destroy();
						PBs[c].splice(i,1);
					}//if
				}//for
				
				
			}
			
		
		}//out
		//豌豆命中管理器
		public function hit():void{
			for(var c:int=1;c<=5;c++){
				for(var zom:int=0;zom<Zombies[c].length;zom++){//for:zom
					for(var pb:int=0;pb<PBs[c].length;pb++){//for:pb
						if(Zombies[c][zom].x<(PBs[c][pb].x-20)&&(Zombies[c][zom].x+70)>(PBs[c][pb].x-20)){//if
							Zombies[c][zom].hit();
							PBs[c][pb].destroy();
							PBs[c].splice(pb,1);
							}//if
						
						
						}//for:pb
					if(Zombies[c][zom].getHp()<0){
						Zombies[c][zom].destroy();
						Zombies[c].splice(zom,1);
						this.playerScore+=10;//奖励10分
					}
					
				}
				
				
			}
			
			
		}
		
		/*********************************************************************************
		***推草机管理器
		*/
		//推草机是否与僵尸碰撞
		function isCarHit():void{
			for(var c:int =1;c<=5;c++){
				for(var i:int=0;i<Zombies[c].length;i++){
					if(Cars[c]!=null)
					if(Zombies[c][i].x<Cars[c].x){
						Cars[c].setIsHit(true);
						Zombies[c][i].destroy();
						Zombies[c].splice(i,1)
						this.playerScore+=10;//奖励10分
					}
					
				}
				
			}
			
		}
		//推草机前进
		function carGo():void{
			for(var c:int=1;c<=5;c++){
				if(Cars[c]!=null)
				if(Cars[c].getIsHit()){
					Cars[c].x=Cars[c].x+10;
				}
			}
			
		}
		//推草机越界约束器，将越界的推土机销毁
		public function  CarOutOfBounds():void{
			for(var i:int=1;i<=5;i++){
				if(Cars[i]!=null)
				if(Cars[i].x>1000){
					Cars[i].destroy();
					//Cars.splice(i,1);
					Cars[i]=null;
					
				}
				
			}
			
		
		}//out
		
		/*********************************************************************************
		***卡片管理器
		*/
		//卡片选择器
		function PeashooterDown(e:Event):void{
			//豌豆射手
				this._selected_NewItem="Peashooter";
				this.newMousePicture=new Peashooter();
				changeMouse();
		}
		function PotatoMineDown(e:Event):void{
			//土豆雷
			this._selected_NewItem="PotatoMine";
			
		}
		function PumpkinHeadDown(e:Event):void{
			//南瓜头
			this._selected_NewItem="PumpkinHead";
		}
		function sunflowerDown(e:Event):void{
			//向日葵
			this.newMousePicture=new SunFlower();
			this._selected_NewItem="sunflower";
			changeMouse();
		}
		function TwinSunflowerDown(e:Event):void{
			//姐妹向日葵
			this._selected_NewItem="TwinSunflower";
		}
		function WallNutDown(e:Event):void{
			//坚果
			this._selected_NewItem="WallNut";
		}
		/*********************************************************************************
		***鼠标事件管理器
		*/
		//侦听PSC鼠标按下
		/*function _PSC_mouseDown(e:Event):void
		{
			this._selected_item="PSC";
			if(_selected){
				
				_selected=false;
				
			}else{
				if(sunNumber-100>=0){
					
				}
			}
			
		}*/
		//鼠标形状管理器
		function initMouse(){
			
			
		}
		function changeMouse(){
			trace(this.sunNumber);
					var isEM:Boolean=true;//isEnoughMoney
					switch(this._selected_NewItem){
						case "Peashooter":
							isEM=this.sunNumber>=100;
							break;
						case "sunflower":
							isEM=this.sunNumber>=50;
							break;
						default:
							break;
					}				
					trace(isEM);
					if(this._selected_item=="0"&&isEM){
						Mouse.hide();
						this.mousePicture=this.newMousePicture;
						this._selected_item=this._selected_NewItem;
						this.mousePicture.x=mouseX;
						this.mousePicture.y=mouseY;
						this.mousePicture.visible=true;
						this.addChild(mousePicture);
						this._selected=true;
					}else{
						if(this._selected_item==this._selected_NewItem){
							Mouse.show();
							this.mousePicture.visible=false;
							this._selected_item="0";
							this.removeChild(this.mousePicture);
							this._selected=false;
						}else{
							if(isEM){
								this._selected_item=this._selected_NewItem;
							this.mousePicture.visible=false;
							this.removeChild(mousePicture);
							this.mousePicture=this.newMousePicture;
							this.mousePicture.x=mouseX;
							this.mousePicture.y=mouseY;
							this.mousePicture.visible=true;
							this.addChild(mousePicture);
							this._selected=true;
								
							}
						}
						
						
					}
					
					//mousePicture=new Peashooter();
					/*mousePicture.visible=true;
					this.addChild(mousePicture);
					mousePicture.x=mouseX;
					mousePicture.y=mouseY;
					_selected=true;*/
		}
		
		
		
		//鼠标移动侦听器
		function _mouseMove(e:Event):void
		{
			if(_selected){
				mousePicture.x=mouseX;
				mousePicture.y=mouseY;
			}
			
		}
		//侦听鼠标按下,在方格种植植物
		function _mouseDown(e:Event):void
		{
			//trace("x="+mouseX+"y="+mouseY);
			var isEM:Boolean=true;//isEnoughMoney
			switch(this._selected_item){
				case "Peashooter":
					isEM=this.sunNumber>=100;
					break;
				case "sunflower":
					isEM=this.sunNumber>=50;
					break;
				default:
					break;
			}
			
			
			
			if(_selected&&isEM){
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
								var plant:DisplayObject; 
								var money:int=100;
								if(this._selected_item=="Peashooter"){
									plant=new Peashooter();
									money=100;
								}else if(this._selected_item=="sunflower"){
									plant=new SunFlower();
									money=50;
								}else{
									plant=new Peashooter();
								}
								//var pla:Peashooter=new Peashooter();
								plant.x=260+80*x;
								plant.y=100+100*y;
								plant.visible=true;
								this.addChild(plant);
								if(this._selected_item=="Peashooter"){
									Plas[row].push(plant);
								}else if(this._selected_item=="sunflower"){
									sunFlowers[row].push(plant);
								}else {
									Plas[row].push(plant);
								}
								this.sunNumber=this.sunNumber-money;
								
								Mouse.show();
								//mousePicture.destroy();
								this.mousePicture.visible=false;
								this.removeChild(this.mousePicture);
								_selected=false;
								this._selected_item="0";
								break;
							}
						}
					}//判断种植的方格
					
				}//是否在种植区域
			}//判断选择状态
		}//方法结束
		/*********************************************************************************
		***游戏服务调度管理器
		*/
		public function serves(event:Event){
			 OutOfBounds();//豌豆越界管理器
			 hit();//豌豆碰撞管理器
			 
			 ZomOutOfBounds();//僵尸越界约束器
			 ZomAttack();//僵尸攻击协调器
			 ZomGo();//僵尸前进转换器
			 
			 isCarHit();//推草机碰撞管理器
			 carGo();//推草机运动管理器
			 CarOutOfBounds();//推草机越界约束器
			 
			 sunText.text=sunNumber.toString();//太阳显示器
			 playerScoreText.text="="+this.playerScore.toString();
		}
	}
}
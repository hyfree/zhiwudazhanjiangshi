import flash.utils.Timer;
import flash.events.TimerEvent;
import flash.events.KeyboardEvent;
import flash.events.Event;
import flash.ui.Keyboard;



stop();
//飞机实例为：cat_mc
var zidan:Array = new Array();//储存子弹实例数组
var enemy:Array = new Array();//储存敌人飞机实例数组
var score:int = 0;			//玩家得分
const mScreenHeight:int = 480;//config-舞台高度=480
var enemyPlaneTimer:Timer = new Timer(3000);//定时器
enemyPlaneTimer.start();
enemyPlaneTimer.addEventListener(TimerEvent.TIMER,newEnemyPlane);
this.setChildIndex(p1,0);
this.setChildIndex(p2,1);
stage.addEventListener(KeyboardEvent.KEY_DOWN,movecat);//监听键盘事件，触发moveCat函数
stage.addEventListener(Event.ENTER_FRAME,movezidan);

/**
根据参数e，移动飞机实例
*/
function movecat(event:KeyboardEvent)
{
	answer_txt.text = "你按下："+String.fromCharCode(event.charCode);
	if(event.keyCode == Keyboard.DOWN)
	{
		answer_txt.text = "你按下：向下键";
		cat_mc.y += 10;
	}
	if(event.keyCode == Keyboard.UP)
	{
		answer_txt.text = "你按下：向上键";
		cat_mc.y -= 10;
	}
	if(event.keyCode == Keyboard.LEFT)
	{
		answer_txt.text = "你按下：向左键";
		cat_mc.x -= 10;
	}
	if(event.keyCode == Keyboard.RIGHT)
	{
		answer_txt.text = "你按下：向右键";
		cat_mc.x += 10;
	}
	if(cat_mc.x>400)
	{
		gotoAndPlay(30);
	}
	if(event.keyCode == Keyboard.SPACE)
	{
		answer_txt.text = "你按下：空格键";
		var b1:bullet = new bullet();//子弹对象
		b1.y = cat_mc.y;
		b1.x = cat_mc.x;
		b1.visible = true;
		zidan.push(b1);
		addChild(b1);
		
	}
}




//负责生产敌方飞机
function newEnemyPlane(event:Event)
{
	var e1:enemy_plane = new enemy_plane();
	e1.y = Math.floor(Math.random()*200);
	e1.x = Math.floor(Math.random()*300);
	e1.visible = true;
	enemy.push(e1);
	addChild(e1);
}




function movezidan(event:Event)
{
	var i,j:int;
	var e1:enemy_plane;
	updateBg();
	///遍历数组，移动敌方飞机的位置
	for(j = 0;j<enemy.length;j++)
	{
		enemy[j].y += 3;
	}
	
	for(i = 0;i<zidan.length;i++)
	{
		var b1:bullet = zidan[i];
		if(b1.visible == true && b1.y>0)
		{
			//子弹可见，并且未脱离舞台，移动子弹位置
			b1.y -= 5;
			//遍历子弹数组和敌机数组，判断碰撞
			for(j = 0;j<enemy.length;j++)
			{
				
				e1 = enemy[j];
				if(b1.hitTestObject(e1))//如果b1（子弹）与el（敌机）碰撞
				{
					//1、生产一个爆炸实例立即从数组索引中移除子弹实例，立即从舞台上移除子弹实例
					//2、立即从数组索引中移除子弹实例，立即从舞台上移除子弹实例
					//3、移除敌机数组索引中的对象，移除舞台上的对象
					//4、计算得分
					var bo:bomb_enemy = new bomb_enemy();
					bo.x = e1.x;
					bo.y = e1.y;
					this.addChild(bo);
					enemy.splice(j,1);
					this.removeChild(e1);
					zidan.splice(i,1);
					this.removeChild(b1);
					score += 10;
					answer_txt.text = String(score);
				}
			}
		}
		else if(b1.visible == true && b1.y<0)
		{
			//子弹超出舞台，销毁
			b1.visible = false;
			zidan.splice(i,1);
			this.removeChild(b1);
	    }
	}
	//遍历敌机数组，判断是否与本机碰撞
	for(i = 0;i<enemy.length;i++)
		{
			e1 = enemy[i];
			if(e1!=null && cat_mc!=null && cat_mc.hitTestObject(e1))
			{
				//停止计时器，并移除
				enemyPlaneTimer.stop();
			    enemyPlaneTimer.removeEventListener(TimerEvent.TIMER,newEnemyPlane);
				for(j = enemy.length-1;j>=0;j--)
				{
					e1 = enemy[j];
					enemy.splice(j,1);
					this.removeChild(e1);
				}
				answer_txt.text = "敌机碰到玩家自己的飞机，游戏结束！";
				//跳转到30帧并播放
				gotoAndPlay(30);
			
			}
		}    
}



//负责更新地图背景
function updateBg()
{
	p1.y += 5;
	p2.y += 5;
	if(p1.y >= mScreenHeight)
	{
		p1.y = -mScreenHeight;
		this.setChildIndex(p2,0);
	}
	if(p2.y >= mScreenHeight)
	{
		p2.y = -mScreenHeight;
		this.setChildIndex(p1,0);
	}

}

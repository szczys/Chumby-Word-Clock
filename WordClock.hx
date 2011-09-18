import flash.events.TimerEvent;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.display.MovieClip;
import flash.events.Event;

class WordClock
{
	static var clockTimer:Timer;
	static var s:flash.display.MovieClip;
	static var mc_background = new MovieClip();
	static var mc_it:MovieClip = new MovieClip();
	static var mc_is:MovieClip = new MovieClip();
	static var mc_half:MovieClip = new MovieClip();
	static var mc_ten:MovieClip = new MovieClip();
	static var mc_quarter:MovieClip = new MovieClip();
	static var mc_twenty:MovieClip = new MovieClip();
	static var mc_five:MovieClip = new MovieClip();
	static var mc_minutes:MovieClip = new MovieClip();
	static var mc_past:MovieClip = new MovieClip();
	static var mc_to:MovieClip = new MovieClip();
	static var mc_one:MovieClip = new MovieClip();
	static var mc_two:MovieClip = new MovieClip();
	static var mc_three:MovieClip = new MovieClip();
	static var mc_four:MovieClip = new MovieClip();
	static var mc_five_hours:MovieClip = new MovieClip();
	static var mc_seven:MovieClip = new MovieClip();
	static var mc_six:MovieClip = new MovieClip();
	static var mc_eight:MovieClip = new MovieClip();
	static var mc_nine:MovieClip = new MovieClip();
	static var mc_ten_hours:MovieClip = new MovieClip();
	static var mc_eleven:MovieClip = new MovieClip();
	static var mc_twelve:MovieClip = new MovieClip();
	static var mc_oclock:MovieClip = new MovieClip();
	
	
	
	static var bg_color;
	static var fg_color;
	static var colors = new Array();
	
	static var button:MovieClip = new MovieClip();
	static var mcArray = new Array();
	static var tracker;
	
    static function main() {
		
		tracker = 0;
		bg_color = 0;
		fg_color = 4;
		
		colors = [0xFFFFFF,0xC0C0C0,0x808080,0x000000,0xFF0000,0x808000,0x00FF00,0x008000,0x00FFFF,0x008080,0x0000FF,0x000080,0xFF00FF,0x800080];
		
		mc_background.graphics.beginFill(colors[bg_color]);
        mc_background.graphics.drawRect(0,0,800,600);
        mc_background.graphics.endFill();
        
        button.graphics.beginFill(colors[fg_color]);
        button.graphics.drawRect(390,290,20,20);
        button.graphics.endFill();
        
        flash.Lib.current.addChild(mc_background);
        
		
		/*
		mc_it = new MovieClip();
		mc_is = new MovieClip();
		mc_half = new MovieClip();
		mc_ten = new MovieClip();
		mc_quarter = new MovieClip();
		mc_twenty = new MovieClip();
		mc_five = new MovieClip();
		mc_minutes = new MovieClip();
		mc_past = new MovieClip();
		mc_to = new MovieClip();
		mc_one = new MovieClip();
		mc_two = new MovieClip();
		mc_three = new MovieClip();
		mc_four = new MovieClip();
		mc_five_hours = new MovieClip();
		mc_seven = new MovieClip();
		mc_six = new MovieClip();
		mc_eight = new MovieClip();
		mc_nine = new MovieClip();
		mc_ten_hours = new MovieClip();
		mc_eleven = new MovieClip();
		mc_twelve = new MovieClip();
		mc_oclock = new MovieClip();
		*/
		
		mcArray = [mc_it,mc_one,mc_two,mc_three,mc_four,mc_five_hours,mc_seven,mc_six,mc_eight,mc_nine,mc_ten_hours,mc_eleven,mc_twelve,mc_is,mc_half,mc_ten,mc_quarter,mc_twenty,mc_five,mc_minutes,mc_past,mc_to,mc_oclock];		
        
        createMC(mc_it,0,0,130,76);
        createMC(mc_is,195,0,115,76);
        createMC(mc_half,375,0,235,76);
        createMC(mc_ten,610,0,175,76);
        createMC(mc_quarter,0,76,430,76);
        createMC(mc_twenty,430,76,355,76);
        createMC(mc_five,0,155,250,61);
        createMC(mc_minutes,310,140,420,76);
        createMC(mc_past,0,204,250,76);
        createMC(mc_to,550,204,125,76);
        createMC(mc_one,0,268,185,76);
        createMC(mc_two,250,268,180,76);
        createMC(mc_three,485,268,300,76);
        createMC(mc_four,0,332,250,76);
        createMC(mc_five_hours,250,332,240,76);
        createMC(mc_seven,490,332,295,76);
        createMC(mc_six,0,396,190,76);
        createMC(mc_eight,190,396,300,76);
        createMC(mc_nine,550,396,235,76);
        createMC(mc_ten_hours,0,460,185,76);
        createMC(mc_eleven,185,460,370,76);
        createMC(mc_twelve,0,524,370,76);
        createMC(mc_oclock,430,524,355,76);

		//Add image overlay
        s = flash.Lib.attach("alum-bg");
        flash.Lib.current.addChild(s);
        
        showTime();
        
        //start timer
        clockTimer = new Timer(500);
        clockTimer.addEventListener(TimerEvent.TIMER, updateTime);
        clockTimer.start();
        
        flash.Lib.current.addChild(button);
        button.buttonMode = true;
        
        //listen for mouse events
        button.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownhandler);
        flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUphandler);
    }
    
    static function createMC(mc:MovieClip,x,y,width,height){
        mc.graphics.beginFill(colors[fg_color]);
        mc.graphics.drawRect(x,y,width,height);
        mc.graphics.endFill();
        mc.visible = false;
        flash.Lib.current.addChild(mc);		
	}
	
	static function showMC(mc:MovieClip){
		mc.visible = true;
	}
	
	static function allOff(){
		for (i in mcArray){
			i.visible = false;
		}
	}
	
	static function showTime(){
		allOff();
		/*
		showMC(mcArray[tracker]);
		tracker += 1;
		if (tracker >= mcArray.length){
			tracker = 0;
		}
		*/
		
		var curDate:Date = Date.now();
		var hours = curDate.getHours();
		var minutes = curDate.getMinutes();
		
		//Adjust for 24 hour time
		if (hours == 0) {
			hours = 12;
		}
		if (hours > 12) {
			hours -= 12;
		}
		
		//Logic to display time
		showMC(mc_it);
		showMC(mc_is);
		
		if (minutes < 5) {
			showMC(mc_oclock);
			showMC(mcArray[hours]);
		}
		else if (minutes < 35) {
			showMC(mc_past);
			showMC(mcArray[hours]);
			if (minutes < 10) {
				showMC(mc_five);
				showMC(mc_minutes);
			}
			else if (minutes < 15) {
				showMC(mc_ten);
				showMC(mc_minutes);
			}
			else if (minutes < 20) {
				showMC(mc_quarter);
			}
			else if (minutes < 30) {
				showMC(mc_twenty);
				showMC(mc_five);
				showMC(mc_minutes);
			}
			else {
				showMC(mc_half);
			}
		}
		else {
			showMC(mc_to);
			var adjustHours = hours+1;
			if (adjustHours > 12) { adjustHours = 1; }
			showMC(mcArray[adjustHours]);
			if (minutes < 40) {
				showMC(mc_twenty);
				showMC(mc_five);
				showMC(mc_minutes);
			}
			else if (minutes < 45) {
				showMC(mc_twenty);
				showMC(mc_minutes);
			}
			else if (minutes < 50) {
				showMC(mc_quarter);
			}
			else if (minutes < 55) {
				showMC(mc_ten);
				showMC(mc_minutes);
			}
			else {
				showMC(mc_five);
				showMC(mc_minutes);
			}
		}
	}
	
    static function updateTime(evt:TimerEvent){
		showTime();
		//TODO: only change when minutes have changed		
	}
	
	static function changeBGcolor(colorIndex){
		var newColorTransform:flash.geom.ColorTransform = mc_background.transform.colorTransform;
		newColorTransform.color = colors[colorIndex];
		mc_background.transform.colorTransform = newColorTransform;
	}
	
	static function onNewFrame(event:Event){
		bg_color += 1;
		if (bg_color >= colors.length) { bg_color = 0; }
		changeBGcolor(bg_color);
	}
	
	static function onMouseDownhandler (event:MouseEvent){
		trace(event.currentTarget.x);
		trace(event.target.x);
		button.startDrag(false,new flash.geom.Rectangle(-390,0,780,0));
		button.addEventListener(Event.ENTER_FRAME, onNewFrame);
/*
		bg_color += 1;
		if (bg_color >= colors.length) { bg_color = 0; }
		changeBGcolor(bg_color);
*/
	}
	
	static function onMouseUphandler (event:Event){
		button.stopDrag();
		button.removeEventListener(Event.ENTER_FRAME, onNewFrame);
	}
}

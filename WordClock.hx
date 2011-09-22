import flash.events.TimerEvent;
import flash.events.MouseEvent;
import flash.utils.Timer;
import flash.display.MovieClip;
import flash.text.TextField;
import flash.events.Event;

class WordClock
{	
	inline static var CONTROLS_X = 80;
	inline static var CONTROLS_Y = 60;
	inline static var CONTROLS_WIDTH = 640;
	inline static var CONTROLS_HEIGHT = 480;
	inline static var CONTROLS_SPACING = CONTROLS_HEIGHT/48;
	inline static var SET_FOREGROUND = 0;
	inline static var SET_BACKGROUND = 1;
	
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
	
	//Controls
	static var controls:MovieClip = new MovieClip();
	static var close_controls:MovieClip = new MovieClip();
	static var red_button:MovieClip = new MovieClip();
	static var blue_button:MovieClip = new MovieClip();
	static var green_button:MovieClip = new MovieClip();
	static var bg_red;
	static var bg_green;
	static var bg_blue;
	static var fg_red;
	static var fg_green;
	static var fg_blue;
	static var label_setColor:TextField = new TextField();
	static var label_foreground:TextField = new TextField();
	static var label_background:TextField = new TextField();
	static var set_text_color_tracker;
	
	static var colors = new Array();
	
	
	static var mcArray = new Array();
	
    static function main() {
		
		set_text_color_tracker = SET_BACKGROUND;
		bg_red = 255;
		bg_green = 255;
		bg_blue = 255;
		fg_red = 255;
		fg_green = 0;
		fg_blue = 0;
				
		colors = [0xFFFFFF,0xC0C0C0,0x808080,0x000000,0xFF0000,0x808000,0x00FF00,0x008000,0x00FFFF,0x008080,0x0000FF,0x000080,0xFF00FF,0x800080];
		
		mc_background.graphics.beginFill(rgb2hex(bg_red,bg_green,bg_blue));
        mc_background.graphics.drawRect(0,0,800,600);
        mc_background.graphics.endFill();
        
        flash.Lib.current.addChild(mc_background);
		
		mcArray = [mc_it,mc_one,mc_two,mc_three,mc_four,mc_five_hours,mc_six,mc_seven,mc_eight,mc_nine,mc_ten_hours,mc_eleven,mc_twelve,mc_is,mc_half,mc_ten,mc_quarter,mc_twenty,mc_five,mc_minutes,mc_past,mc_to,mc_oclock];		
        
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
        
        /****************************
         * Controls					*
         * **************************/
        
        //Control panel
        controls.graphics.lineStyle(2,0x000000);
        controls.graphics.beginFill(0xC0C0C0);
        controls.graphics.drawRoundRect(CONTROLS_X,CONTROLS_Y,CONTROLS_WIDTH,CONTROLS_HEIGHT,CONTROLS_SPACING,CONTROLS_SPACING);
        controls.graphics.moveTo(CONTROLS_X+CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*3));
        controls.graphics.lineTo(CONTROLS_X+CONTROLS_WIDTH -CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*3));
        controls.graphics.moveTo(CONTROLS_X+CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*8));
        controls.graphics.lineTo(CONTROLS_X+CONTROLS_WIDTH -CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*8));
        controls.graphics.moveTo(CONTROLS_X+CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*13));
        controls.graphics.lineTo(CONTROLS_X+CONTROLS_WIDTH -CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*13));
        controls.graphics.endFill();
        flash.Lib.current.addChild(controls);
		
		//X icon to close control panel
		close_controls.graphics.lineStyle(2,0x000000);
		close_controls.graphics.beginFill(0x808080);
		close_controls.graphics.drawRoundRect(CONTROLS_X+CONTROLS_WIDTH-5*CONTROLS_SPACING,CONTROLS_Y+CONTROLS_SPACING,CONTROLS_SPACING*4,CONTROLS_SPACING*4,CONTROLS_SPACING,CONTROLS_SPACING);
		close_controls.graphics.moveTo(CONTROLS_X+CONTROLS_WIDTH-5*CONTROLS_SPACING+CONTROLS_SPACING/2,CONTROLS_Y+CONTROLS_SPACING+CONTROLS_SPACING/2);
		close_controls.graphics.lineTo(CONTROLS_X+CONTROLS_WIDTH-CONTROLS_SPACING-CONTROLS_SPACING/2,CONTROLS_Y+5*CONTROLS_SPACING-CONTROLS_SPACING/2);
		close_controls.graphics.moveTo(CONTROLS_X+CONTROLS_WIDTH-5*CONTROLS_SPACING+CONTROLS_SPACING/2,CONTROLS_Y+5*CONTROLS_SPACING-CONTROLS_SPACING/2);
		close_controls.graphics.lineTo(CONTROLS_X+CONTROLS_WIDTH-CONTROLS_SPACING-CONTROLS_SPACING/2,CONTROLS_Y+CONTROLS_SPACING+CONTROLS_SPACING/2);
		close_controls.graphics.endFill();
		controls.addChild(close_controls);
		
		//Sliders for RGB color control
		red_button.graphics.lineStyle(1,0x000000);
		red_button.graphics.beginFill(0xFF0000);
        red_button.graphics.drawRect(CONTROLS_X+CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*15),CONTROLS_SPACING*4,CONTROLS_SPACING*4);
        red_button.graphics.endFill();
        red_button.buttonMode = true;
        red_button.x = getSliderPosition(bg_red); //Load slider position from settings here
        controls.addChild(red_button);
		
		green_button.graphics.lineStyle(1,0x000000);       
        green_button.graphics.beginFill(0x00FF00);
        green_button.graphics.drawRect(CONTROLS_X+CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*10),CONTROLS_SPACING*4,CONTROLS_SPACING*4);
        green_button.graphics.endFill();
        green_button.buttonMode = true;
        green_button.x = getSliderPosition(bg_green); //Load slider position from settings here
        controls.addChild(green_button);
        
        blue_button.graphics.lineStyle(1,0x000000);
        blue_button.graphics.beginFill(0x0000FF);
        blue_button.graphics.drawRect(CONTROLS_X+CONTROLS_SPACING,CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*5),CONTROLS_SPACING*4,CONTROLS_SPACING*4);
        blue_button.graphics.endFill();
        blue_button.buttonMode = true;
        blue_button.x = getSliderPosition(bg_blue); //Load slider position from settings here
        controls.addChild(blue_button);
        
        //Text displayed on panel
        var textFormat:flash.text.TextFormat = new flash.text.TextFormat();
        textFormat.font = "LiberationSerif";
        textFormat.size = CONTROLS_SPACING*3;
        textFormat.align = flash.text.TextFormatAlign.CENTER;
        
        
        label_setColor.defaultTextFormat = textFormat;
        label_setColor.text = "Set Color:";
        label_setColor.x = CONTROLS_X+CONTROLS_SPACING;
        label_setColor.y = CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*20);
        label_setColor.width = (CONTROLS_WIDTH-2*CONTROLS_SPACING)/3;
        controls.addChild(label_setColor);
        
        label_foreground.defaultTextFormat = textFormat;
        label_foreground.text = "Foreground";
        label_foreground.x = CONTROLS_X+CONTROLS_SPACING + (CONTROLS_WIDTH-2*CONTROLS_SPACING)/3;
        label_foreground.y = CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*20);
        label_foreground.width = (CONTROLS_WIDTH-2*CONTROLS_SPACING)/3 - CONTROLS_SPACING;
        label_foreground.height = CONTROLS_SPACING*4;
        label_foreground.borderColor = 0x000000;
        label_foreground.backgroundColor = 0x808080;
        label_foreground.border = false;
        label_foreground.background = false;
        controls.addChild(label_foreground);
        
        label_background.defaultTextFormat = textFormat;
        label_background.text = "Background";
        label_background.x = CONTROLS_X+CONTROLS_SPACING + 2*((CONTROLS_WIDTH-2*CONTROLS_SPACING)/3);
        label_background.y = CONTROLS_HEIGHT+CONTROLS_Y-(CONTROLS_SPACING*20);
        label_background.width = (CONTROLS_WIDTH-2*CONTROLS_SPACING)/3 - CONTROLS_SPACING/2;
        label_background.height = CONTROLS_SPACING*4;
        label_background.borderColor = 0x000000;
        label_background.backgroundColor = 0x808080;
        label_background.border = true;
        label_background.background = true;
        controls.addChild(label_background);
        /*
        var f:flash.text.TextFormat = label_background.getTextFormat();
        var maxTextWidth = label_background.width;
        label_background.width = 1000;
        trace(maxTextWidth);
        while (label_background.textWidth > maxTextWidth){
			trace(label_background.textWidth);
			f.size = Std.int(f.size)-1;
			label_background.setTextFormat(f);
		}
		label_background.width = maxTextWidth;
		* */
        
        //Hide controls at start-up
        controls.visible = false; 
               
        //listen for mouse events
        flash.Lib.current.addEventListener(MouseEvent.MOUSE_DOWN, onMouseDownhandler);
        flash.Lib.current.stage.addEventListener(MouseEvent.MOUSE_UP, onMouseUphandler);
    }
    
    static function createMC(mc:MovieClip,x,y,width,height){
        mc.graphics.beginFill(rgb2hex(fg_red,fg_green,fg_blue));
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
			else if (minutes < 25) {
				showMC(mc_twenty);
				showMC(mc_minutes);
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
	
	static function rgb2hex(bg_red,bg_green,bg_blue) {
		return ((bg_red<<16) | (bg_green<<8) | bg_blue);
	}
	
	static function changeBGcolor(hexColor){
		var newColorTransform:flash.geom.ColorTransform = mc_background.transform.colorTransform;
		newColorTransform.color = hexColor;
		mc_background.transform.colorTransform = newColorTransform;
	}
	
	static function changeFGcolor(hexColor){
		for (mc in mcArray){
			var newColorTransform:flash.geom.ColorTransform = mc.transform.colorTransform;
			newColorTransform.color = hexColor;
			mc.transform.colorTransform = newColorTransform;
		}
	}
	
	static function onNewFrame(slider:MovieClip) : Dynamic {
			return function(event:Event){
				var cents = (slider.x*100)/(CONTROLS_WIDTH-6*CONTROLS_SPACING);
				var color_index = Math.round((255*cents)/100);
				if (set_text_color_tracker == SET_FOREGROUND){
					if (slider == blue_button){
						fg_blue = color_index;
						changeFGcolor(rgb2hex(fg_red,fg_green,fg_blue)); //Blue
					}
					else if (slider == green_button) {
						fg_green = color_index;
						changeFGcolor(rgb2hex(fg_red,fg_green,fg_blue)); //Green
					}
					else {
						fg_red = color_index;
						changeFGcolor(rgb2hex(fg_red,fg_green,fg_blue)); //Red
					}					
				}
				else {
					if (slider == blue_button){
						bg_blue = color_index;
						changeBGcolor(rgb2hex(bg_red,bg_green,bg_blue)); //Blue
					}
					else if (slider == green_button) {
						bg_green = color_index;
						changeBGcolor(rgb2hex(bg_red,bg_green,bg_blue)); //Green
					}
					else {
						bg_red = color_index;
						changeBGcolor(rgb2hex(bg_red,bg_green,bg_blue)); //Red
					}
				}
			}		
	}
	
	static function getSliderPosition(colorValue){
		return (((colorValue*100)/255)*(CONTROLS_WIDTH-(6*CONTROLS_SPACING)))/100;
	}
	
	static function setTextColorSelector(foregroundOrBackground){
		if (foregroundOrBackground == SET_FOREGROUND) {
			set_text_color_tracker = SET_FOREGROUND;
			label_foreground.background = true;
			label_foreground.border = true;
			label_background.background = false;
			label_background.border = false;
			red_button.x = getSliderPosition(fg_red);
			green_button.x = getSliderPosition(fg_green);
			blue_button.x = getSliderPosition(fg_blue);
		}
		else {
			set_text_color_tracker = SET_BACKGROUND;
			label_foreground.background = false;
			label_foreground.border = false;
			label_background.background = true;
			label_background.border = true;
			red_button.x = getSliderPosition(bg_red);
			green_button.x = getSliderPosition(bg_green);
			blue_button.x = getSliderPosition(bg_blue);
		}
	}
	
	static function onMouseDownhandler (event:MouseEvent){
		if (event.target == blue_button){
			blue_button.startDrag(false,new flash.geom.Rectangle(0,0,CONTROLS_WIDTH-(6*CONTROLS_SPACING),0));
			blue_button.addEventListener(Event.ENTER_FRAME, onNewFrame(event.target));
		}
		if (event.target == green_button){
			green_button.startDrag(false,new flash.geom.Rectangle(0,0,CONTROLS_WIDTH-(6*CONTROLS_SPACING),0));
			green_button.addEventListener(Event.ENTER_FRAME, onNewFrame(event.target));
		}
		if (event.target == red_button){
			red_button.startDrag(false,new flash.geom.Rectangle(0,0,CONTROLS_WIDTH-(6*CONTROLS_SPACING),0));
			red_button.addEventListener(Event.ENTER_FRAME, onNewFrame(event.target));
		}
		else if (event.target == s){
			if ((event.target.mouseX>470) &&(event.target.mouseX<510) && (event.target.mouseY>525) && (event.target.mouseY<560)){
				controls.visible = true;
			}
		}
		else if (event.target == close_controls){
			controls.visible = false;
		}
		
		else if (event.target == label_foreground){
			setTextColorSelector(SET_FOREGROUND);
		}
		else if (event.target == label_background){
			setTextColorSelector(SET_BACKGROUND);
		}
		

	}
	
	static function onMouseUphandler (event:Event){
		//trace(event.target.type);
		controls.stopDrag();
		//blue_button.removeEventListener(Event.ENTER_FRAME, onNewFrame(cast(event.target)));
	}
}

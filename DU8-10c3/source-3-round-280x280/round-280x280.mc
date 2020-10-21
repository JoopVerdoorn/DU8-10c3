using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

//! inherit from the view that contains the commonlogic
class DeviceView extends PowerView {
	var myTime;
	var strTime;

	//! it's good practice to always have an initialize, make sure to call your parent class here!
    function initialize() {
        PowerView.initialize();
    }

	function onUpdate(dc) {
		//! call the parent function in order to execute the logic of the parent
		PowerView.onUpdate(dc);
                
		//! Conditions for showing the demoscreen       
        if (uShowDemo == false) {
        	if (licenseOK == false && jTimertime > 900)  {
        		uShowDemo = true;        		
        	}
        }

	   //! Check whether demoscreen is showed or the metrics 
	   if (uShowDemo == false ) {

		//! Draw separator lines
        dc.setColor(mColourLine, Graphics.COLOR_TRANSPARENT);
        dc.setPenWidth(2);

        //! Horizontal dividers
        dc.drawLine(47,  33,  233, 33);
        dc.drawLine(4,   89,  277, 89);
        dc.drawLine(0,   145, 280, 145);
        dc.drawLine(3,   201,  277, 201);
        dc.drawLine(62, 257, 218, 257);

        //! Vertical dividers
        dc.drawLine(139, 34,  139, 90);
        if (uUpperMiddleRowBig == false) {
        	dc.drawLine(85,  90,  85,  146);
        	dc.drawLine(191,  90,  191,  146);
        } else {
        	dc.drawLine(139,  90,  139,  146);
        }
        if (uLowerMiddleRowBig == false) {
        	dc.drawLine(85,  146,  85,  202);
        	dc.drawLine(191, 146,  191, 202);
        } else {
        	dc.drawLine(139, 146,  139, 202);
        }
        dc.drawLine(139, 202, 139, 256);

		//! Display metrics
        dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d");
		//! Show number of laps or clock with current time in top
		if (uMilClockAltern == 0) {		
			dc.drawText(140, -3, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		}

		for (var i = 1; i < 11; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
	    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"091,068,098,022,072,085,040");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"086,068,088,030,072,085,040");
	    		}
	       	} else if ( i == 2 ) {	//!upper row, right
	    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"198,068,215,140,072,195,040");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"193,068,207,148,072,195,040");
	    		}
	       	} else if ( i == 3 ) {  //!middle row, left
	    		if (uUpperMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"042,124,000,000,000,042,096");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"086,114,000,000,000,018,099");
	    		}
	       	} else if ( i == 4 ) {	//!middle row, middle
	    		if (uUpperMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"138,124,000,000,000,138,096");
	    		}
	       	} else if ( i == 5 ) {  //!middle row, right
	    		if (uUpperMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"236,124,000,000,000,235,096");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"193,114,000,000,000,263,099");
	    		}
	       	} else if ( i == 6 ) {	//!lower row, left
	    		if (uLowerMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"042,180,000,000,000,042,152");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"086,170,000,000,000,018,155");
	    		}
	       	} else if ( i == 7 ) {	//!lower row, right
	    		if (uLowerMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"138,180,000,000,000,138,152");
	    		}
	       	} else if ( i == 8 ) {  //!middle row, right
	    		if (uLowerMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"236,180,000,000,000,235,152");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"193,170,000,000,000,263,155");
	    		}
	       	} else if ( i == 9 ) {	//!lower row, left
	    			    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"091,218,104,031,222,093,247");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"086,218,096,039,222,093,247");
	    		}
	       	} else if ( i == 10 ) {	//!lower row, right
	    			    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"198,218,209,137,222,183,247");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"193,218,201,144,222,183,247");
	    		}
       		}       	
		}
		
		//! Bottom battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(107, 259, 63, 18);
		dc.fillRectangle(170, 264, 4, 8);
	
		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Startstatuspwrbr = 110 + Math.round(pwr*0.58)  ;
		var Endstatuspwrbr = 58 - Math.round(pwr*0.58) ;
		dc.fillRectangle(Startstatuspwrbr, 261, Endstatuspwrbr, 14);

		if ( pwr > 50 ) {
			dc.drawText(123+17*(pwr-50)/50, 267, Graphics.FONT_XTINY, pwr.format("%0d") + "%", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		} else{
			dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);
			dc.drawText(154-16*(50-pwr)/50, 267, Graphics.FONT_XTINY, pwr.format("%0d") + "%", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		}	

	   } else {
	   //! Display demo screen
		dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		if (licenseOK == true) {
      		dc.drawText(140, 40, Graphics.FONT_XTINY, "Datarun ultim c0", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(140, 120, Graphics.FONT_TINY, "Registered !!", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(81, 160, Graphics.FONT_XTINY, "License code: ", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(180, 160, Graphics.FONT_MEDIUM, mtest, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(81, 190, Graphics.FONT_XTINY, "C-Code: ", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(170, 190, Graphics.FONT_MEDIUM, CCode, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		} else {
      		dc.drawText(140, 33, Graphics.FONT_XTINY, "License needed !!", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
      		dc.drawText(140, 63, Graphics.FONT_XTINY, "Run is recorded though", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(60, 105, Graphics.FONT_MEDIUM, "ID 0: ", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(161, 99, Graphics.FONT_NUMBER_MEDIUM, ID0+12781, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(60, 155, Graphics.FONT_MEDIUM, "ID 1: " , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(161, 149, Graphics.FONT_NUMBER_MEDIUM, ID1, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(60, 205, Graphics.FONT_MEDIUM, "ID 2: " , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(161, 199, Graphics.FONT_NUMBER_MEDIUM, ID2 , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
      	}
	   }
	   
	}

}
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
        dc.drawLine(43,  30,  217, 30);
        dc.drawLine(3,   82,  257, 82);
        dc.drawLine(0,   134, 260, 134);
        dc.drawLine(3,   186,  257, 186);
        dc.drawLine(57, 238, 203, 238);

        //! Vertical dividers
        dc.drawLine(129, 31,  129, 83);
        if (uUpperMiddleRowBig == false) {
        	dc.drawLine(79,  83,  79,  135);
        	dc.drawLine(178,  83,  178,  135);
        } else {
        	dc.drawLine(129,  83,  129,  135);
        }
        if (uLowerMiddleRowBig == false) {
        	dc.drawLine(79,  135,  79,  187);
        	dc.drawLine(178, 135,  178, 187);
        } else {
        	dc.drawLine(129, 135,  129, 187);
        }
        dc.drawLine(129, 187, 129, 237);

		//! Display metrics
        dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		myTime = Toybox.System.getClockTime(); 
    	strTime = myTime.hour.format("%02d") + ":" + myTime.min.format("%02d");
		//! Show number of laps or clock with current time in top
		if (uMilClockAltern == 0) {		
			dc.drawText(130, -3, Graphics.FONT_MEDIUM, strTime, Graphics.TEXT_JUSTIFY_CENTER);
		}

		for (var i = 1; i < 11; ++i) {
	    	if ( i == 1 ) {			//!upper row, left
	    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"080,062,088,021,067,079,037");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"080,062,081,028,067,079,037");
	    		}
	       	} else if ( i == 2 ) {	//!upper row, right
	    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"179,062,199,131,067,181,037");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"179,062,192,138,067,181,037");
	    		}
	       	} else if ( i == 3 ) {  //!middle row, left
	    		if (uUpperMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"039,114,000,000,000,039,089");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"080,106,000,000,000,016,090");
	    		}
	       	} else if ( i == 4 ) {	//!middle row, middle
	    		if (uUpperMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"128,114,000,000,000,128,089");
	    		}
	       	} else if ( i == 5 ) {  //!middle row, right
	    		if (uUpperMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"219,114,000,000,000,218,089");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"179,106,000,000,000,244,090");
	    		}
	       	} else if ( i == 6 ) {	//!lower row, left
	    		if (uLowerMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"039,166,000,000,000,039,141");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"080,158,000,000,000,016,142");
	    		}
	       	} else if ( i == 7 ) {	//!lower row, right
	    		if (uLowerMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"128,166,000,000,000,128,141");
	    		}
	       	} else if ( i == 8 ) {  //!middle row, right
	    		if (uLowerMiddleRowBig == false) {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"219,166,000,000,000,218,141");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"179,158,000,000,000,244,142");
	    		}
	       	} else if ( i == 9 ) {	//!lower row, left
	    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"080,202,096,029,206,087,229");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"080,202,089,036,206,087,229");
	    		}
	       	} else if ( i == 10 ) {	//!lower row, right
	    		if ( fieldFormat[i].equals("time") == true and fieldValue[i] > 36000) { 
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"179,202,193,126,206,170,229");
	    		} else {
	    			Formatting(dc,i,fieldValue[i],fieldFormat[i],fieldLabel[i],"179,202,186,133,206,170,229");
	    		}
       		}       	
		}
		
		//! Bottom battery indicator
	 	var stats = Sys.getSystemStats();
		var pwr = stats.battery;	
		var mBattcolor = (pwr > 15) ? mColourFont : Graphics.COLOR_RED;
		dc.setColor(mBattcolor, Graphics.COLOR_TRANSPARENT);
		dc.fillRectangle(100, 240, 59, 16);
		dc.fillRectangle(159, 243, 3, 9);

		dc.setColor(mColourBackGround, Graphics.COLOR_TRANSPARENT);
		var Startstatuspwrbr = 102 + Math.round(pwr*0.55)  ;
		var Endstatuspwrbr = 55 - Math.round(pwr*0.55) ;
		dc.fillRectangle(Startstatuspwrbr, 242, Endstatuspwrbr, 12);	

		if ( pwr > 50 ) {
			dc.drawText(114+16*(pwr-50)/50, 247, Graphics.FONT_XTINY, pwr.format("%0d") + "%", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		} else{
			dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);
			dc.drawText(143-17*(50-pwr)/50, 247, Graphics.FONT_XTINY, pwr.format("%0d") + "%", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		}
		
	   } else {
	   //! Display demo screen
		dc.setColor(mColourFont, Graphics.COLOR_TRANSPARENT);

		if (licenseOK == true) {
      		dc.drawText(130, 40, Graphics.FONT_XTINY, "DU8-10c1", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(130, 120, Graphics.FONT_TINY, "Registered !!", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(81, 160, Graphics.FONT_XTINY, "License code: ", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(180, 160, Graphics.FONT_MEDIUM, mtest, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
		} else {
      		dc.drawText(130, 33, Graphics.FONT_XTINY, "License needed !!", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
      		dc.drawText(130, 63, Graphics.FONT_XTINY, "Run is recorded though", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(60, 105, Graphics.FONT_MEDIUM, "ID 0: ", Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(161, 99, Graphics.FONT_NUMBER_MEDIUM, ID0+12781 , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(60, 155, Graphics.FONT_MEDIUM, "ID 1: " , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(161, 149, Graphics.FONT_NUMBER_MEDIUM, ID1, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(60, 205, Graphics.FONT_MEDIUM, "ID 2: " , Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
			dc.drawText(161, 199, Graphics.FONT_NUMBER_MEDIUM, ID2, Graphics.TEXT_JUSTIFY_CENTER|Graphics.TEXT_JUSTIFY_VCENTER);
      	}
	   }
	   
	}

}
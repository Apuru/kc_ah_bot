; for expeditions 
; send the fleet 

global savedx ; mouse move pos
global savedy ;

doubleclick_send2() {
	Rand_ControlClick(648,477,719,503) ;; click send 1
	rand_sleep(2500,5000)
	Rand_ControlClick(568,476,703,509) ;; click send again (default is fleet 2)
	rand_sleep(8000,12000)
	flag_sendfleet2 := 0
	flag_auto2 := 0
	flag_expedition_2_back := 0
	} 

doubleclick_send3() {
	Rand_ControlClick(648,477,719,503) ;; click send 1
	rand_sleep(2500,5000)
	Rand_ControlClick(425,160,434,172) ;; click fleet 3
	rand_sleep(2500,5000)
	Rand_ControlClick(568,476,703,509) ;; click send again (set to fleet 3)
	rand_sleep(8000,12000)
	flag_sendfleet3 := 0
	flag_auto3 := 0
	flag_expedition_3_back := 0
	} 
	
doubleclick_send4() {
	Rand_ControlClick(648,477,719,503) ;; click send 1
	rand_sleep(2500,5000)
	Rand_ControlClick(454,159,467,172) ;; click fleet 4
	rand_sleep(2500,5000)
	Rand_ControlClick(568,476,703,509) ;; click send again (set to fleet 4)
	rand_sleep(8000,12000)
	flag_sendfleet4 := 0
	flag_auto4 := 0
	flag_expedition_4_back := 0
	} 

	; select all ships and resupply
	/*
	selectall_resup() {
		resup := 0
		loop {
			Rand_ControlClick(120,422,131,433) ; select all ships 
			
			
			if (resupply_box_check() = 1) { ; if empty box exists
				Rand_ControlClick(120,422,131,433) ; select all ships 
				Sleep 300
				}
				
			if (resupply_box_check() = 1) { ; if empty box is still there
				resup += 1 ; control variable incase we loop too much
				continue ; restart loop
				}
			if (resupply_box_check() = 0 OR resup = 50) {
				break ; exit loop
				}
			}
		rand_sleep(500,1000)
		Rand_ControlDoubleClick(664,735,755,759) ; resupply! double click to ensure it goes through

		; everything above was removed because of UI patch 2015-10-09
		rand_sleep(500,1000)
		Rand_ControlDoubleClick(120,422,131,433) ; select all ships 
		resupply_checker() ; check if it was successful  
		rand_sleep(5000,10000)
		}
	*/
		
; everything above was removed because of UI patch 2015-10-09
; select all ships and resupply
selectall_resup() {
	DebugLog("Selecting all and resupplying`n")
	rand_sleep(500,1000)
	; GuiControlGet MoveMouse ; get the mouse move check box ; depreciated 
	Rand_ControlDoubleClick(119,160,132,174) ;; select all ships 
	; rand_sleep(1500,3000) ; wait for resupply to finish
	; resupply_checker() ; check if it was successful  
	rand_sleep(3000,5000)
	resupply_checker() ; check for resupply
	
	}

custom_send2() {
	GuiControlGet ExpList2
	if ExpList2 = 04(Buckets)
		{
		DebugLog("Fleet 2 is going to expedition 4.`n")
		expedition_select(1,4)
		doubleclick_send2()
		Timer("Expedition_2",3000000) ; set for 50 minutes
		}
		else if ExpList2 = 10(Buckets)
			{
			DebugLog("Fleet 2 is going to expedition 10.`n")
			expedition_select(2,2)
			doubleclick_send2()
			Timer("Expedition_2",5400000) ; set for 90 minutes
			}
		else if ExpList2 = 21(Fuel)
			{
			DebugLog("Fleet 2 is going to expedition 21.`n")
			expedition_select(3,5)
			doubleclick_send2()
			Timer("Expedition_2",8400000) ; set for 140 minutes
			}
		else if ExpList2 = 37(Ammo+Steel)
			{
			DebugLog("Fleet 2 is going to expedition 37.`n")
			expedition_select(5,5)
			doubleclick_send2() ; send the fleet!
			Timer("Expedition_2",9900000) ; set for 165 minutes / 2hr45m
			}
		else if ExpList2 = 38(Fuel+Steel)
			{
			DebugLog("Fleet 2 is going to expedition 38.`n")
			expedition_select(5,6)
			doubleclick_send2() ; send the fleet!
			Timer("Expedition_2",10500000) ; set for 175 minutes / 2hr55m
			}
	}
	
custom_send3() {
	GuiControlGet ExpList3
	if ExpList3 = 04(Buckets)
		{
		DebugLog("Fleet 3 is going to expedition 4.`n")
		expedition_select(1,4)
		doubleclick_send3()
		Timer("Expedition_3",3000000) ; set for 50 minutes
		}
		else if ExpList3 = 10(Buckets)
			{
			DebugLog("Fleet 3 is going to expedition 10.`n")
			expedition_select(2,2)
			doubleclick_send3()
			Timer("Expedition_3",5400000) ; set for 90 minutes
			}
		else if ExpList3 = 21(Fuel)
			{
			DebugLog("Fleet 3 is going to expedition 21.`n")
			expedition_select(3,5)
			doubleclick_send3()
			Timer("Expedition_3",8400000) ; set for 140 minutes
			}
		else if ExpList3 = 37(Ammo+Steel)
			{
			DebugLog("Fleet 3 is going to expedition 37.`n")
			expedition_select(5,5)
			doubleclick_send3() ; send the fleet!
			Timer("Expedition_3",9900000) ; set for 165 minutes / 2hr45m
			}
		else if ExpList3 = 38(Fuel+Steel)
			{
			DebugLog("Fleet 3 is going to expedition 38.`n")
			expedition_select(5,6)
			doubleclick_send3() ; send the fleet!
			Timer("Expedition_3",10500000) ; set for 175 minutes / 2hr55m
			}
		}	
	
custom_send4() {
	GuiControlGet ExpList4
	if ExpList4 = 04(Buckets)
		{
		DebugLog("Fleet 4 is going to expedition 4.`n")
		expedition_select(1,4)
		doubleclick_send4()
		Timer("Expedition_4",3000000) ; set for 50 minutes
		}
		else if ExpList4 = 10(Buckets)
			{
			DebugLog("Fleet 4 is going to expedition 10.`n")
			expedition_select(2,2)
			doubleclick_send4()
			Timer("Expedition_4",5400000) ; set for 90 minutes
			}
		else if ExpList4 = 21(Fuel)
			{
			DebugLog("Fleet 4 is going to expedition 21.`n")
			expedition_select(3,5)
			doubleclick_send4()
			Timer("Expedition_4",8400000) ; set for 140 minutes
			}
		else if ExpList4 = 37(Ammo+Steel)
			{
			DebugLog("Fleet 4 is going to expedition 37.`n")
			expedition_select(5,5)
			doubleclick_send4() ; send the fleet!
			Timer("Expedition_4",9900000) ; set for 165 minutes / 2hr45m
			}
		else if ExpList4 = 38(Fuel+Steel)
			{
			DebugLog("Fleet 4 is going to expedition 38.`n")
			expedition_select(5,6)
			doubleclick_send4() ; send the fleet!
			Timer("Expedition_4",10500000) ; set for 175 minutes / 2hr55m
			}
		else if ExpList4 = 39
			{
			DebugLog("Fleet 4 is going to expedition 39.`n")
			expedition_select(5,7)
			doubleclick_send4() ; send the fleet!
			Timer("Expedition_4",9910500000) ; set for too long
			}
		}

expedition_claim() { ; claim expedition rewards
	while (home_screen_check() = 0) {
	Rand_ControlClick(349,352,737,498) ;; click somewhere to get expedition results 
	rand_sleep(1500,3000)
		/*
		if (disconnect_check() = 1) { ; means we've disconnected
		ToolTip, Looks like we've disconnected.`nWaiting 3 minutes.,25,45
		Sleep 18000
		ToolTip, Attempting to reconnect now.,25,45
		reconnect()
			} 
		*/
		} 
	}
	
expedition_screen_check() { ; determines if we're on the expedition fleet send screen, for some reason its required for the stupid if statements with flags (don't ask)
	Coordmode Pixel 
	ImageSearch, expofoundX, expofoundY, -1680, 0, 3600, 1080, images/exposcreen.bmp ;
		if (ErrorLevel = 0) {
		exposcreen_ok := 1 ; This is home screen.
		} 
	ImageSearch, expofoundX, expofoundY, -1680, 0, 3600, 1080, images/exposcreen2.bmp ;
		if (ErrorLevel = 0) {
		exposcreen_ok := 1 ; This is home screen.
		} 
	ImageSearch, expofoundX, expofoundY, -1680, 0, 3600, 1080, images/exposcreen3.bmp ;
		if (ErrorLevel = 0) {
		exposcreen_ok := 1 ; This is home screen.
		} 
	ImageSearch, expofoundX, expofoundY, -1680, 0, 3600, 1080, images/exposcreen4.bmp ;
		if (ErrorLevel = 0) {
		exposcreen_ok := 1 ; This is home screen.
		} 
	ImageSearch, expofoundX, expofoundY, -1680, 0, 3600, 1080, images/exposcreen5.bmp ;
		if (ErrorLevel = 0) {
		exposcreen_ok := 1 ; This is home screen.
		} 
		if (exposcreen_ok = 1) {
		return 1 ; success
		} else {
		return 0
		}	
	} 

home_screen_check_expedition() { ; Checks if the current screen is the home screen with expedition complete  
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, expeditX, expeditY, -1680, 0, 3600, 1080, images/expedition.bmp ; searches under the expedition speech bubble 
		if (ErrorLevel = 0) {
		expedition_ok := 1 ; This is home screen.
		} 
	ImageSearch, expeditX, expeditY, -1680, 0, 3600, 1080, images/expedition2.bmp ; searches for expedition flag
		if (ErrorLevel = 0) {
		expedition_ok := 1 ; This is home screen.
		} 	
		if (expedition_ok = 1) {
		return 1 ; success
		} else {
		return 0 
		}
	}
	
exp_claim() {
	if (home_screen_check_expedition() = 1) { ; lets send the expedition on expedition 5 again
		DebugLog("Claiming our loots!`n")
		expedition_claim()
		return
		}
	if (home_screen_check() = 0) { ; if we're not on the homescreen, lets try and go there.
		DebugLog("We're not home, attempting to return!`n")
		Rand_ControlClick(11,55,90,125) ;; click home button 
		rand_sleep(6000,9000)
		} 
		else if (home_screen_check() = 1) { ; we are on home screen but need to refresh 
			DebugLog("We're home so lets refresh to claim!`n")
			Rand_ControlClick(179,156,226,206) ;; click organize
			rand_sleep(4000,8000)
			Rand_ControlClick(11,55,90,125) ;; click home button 
			rand_sleep(4000,8000)
			}
	if (home_screen_check_expedition() = 1) { 
		DebugLog("Claiming our loots!`n")
		expedition_claim()
		}
	}
	

; the send expedition macro, could be a little cleaner 
; 1 - send to 2
; 2 - send to 3
; 3 - send to 5
; 4 - send to 6
; 5 - custom expedition, 
; custom: 37, 38 (tokyo express)

send_expedition() { 
	if (home_screen_check() = 0) {
		DebugLog("We're not home, attempting to return!`n")
		Rand_ControlClick(11,55,90,125) ;; click home button 
		rand_sleep(6000,9000)
		}
	if (home_screen_check_expedition() = 1) { ; 
		DebugLog("Found expedition screen. Claiming loots first.`n")
		expedition_claim()
		rand_sleep(10000,30000) ; need a long wait for timers to finish
		}	
	if (home_screen_check() = 1) {
			DebugLog("Moving to expedition page...`n")
			Rand_ControlClick(167,269,240,346) ;; shutsugeki button 
			rand_sleep(2500,5000) 
			Rand_ControlClick(620,202,745,329) ;; expeditions button 
			rand_sleep(2500,5000) 
			
			if (flag_sendfleet2 = 1 and expedition_screen_check() = 1) {
				GuiControlGet 1Expchoicefleet2
				if 1Expchoicefleet2 = 1
					{
					DebugLog("Fleet 2 is going to expedition 2.`n")
					expedition_select(1,2)
					doubleclick_send2() ; send the fleet!
					Timer("Expedition_2",1800000) ; set for 30 minutes 
					}
				GuiControlGet 2Expchoicefleet2
				if 2Expchoicefleet2 = 1
					{
					DebugLog("Fleet 2 is going to expedition 3.`n")
					expedition_select(1,3)
					doubleclick_send2() ; send the fleet! 
					Timer("Expedition_2",1200000) ; set for 20 minutes 
					}
				GuiControlGet 3Expchoicefleet2
				if 3Expchoicefleet2 = 1
					{
					DebugLog("Fleet 2 is going to expedition 5.`n")
					expedition_select(1,5)
					doubleclick_send2() ; send the fleet!
					Timer("Expedition_2",5400000) ; set for 90 minutes 
					}
				GuiControlGet 4Expchoicefleet2
				if 4Expchoicefleet2 = 1
					{
					DebugLog("Fleet 2 is going to expedition 6.`n")
					expedition_select(1,6)
					doubleclick_send2() ; send the fleet!
					Timer("Expedition_2",2400000) ; set for 40 minutes 
					}
				GuiControlGet 5Expchoicefleet2
				if 5Expchoicefleet2 = 1
					{
					custom_send2()
					}
		}
			
			if (flag_sendfleet3 = 1 and expedition_screen_check() = 1) {
				GuiControlGet 1Expchoicefleet3
				if 1Expchoicefleet3 = 1 
					{
					DebugLog("Fleet 3 is going to expedition 2.`n")
					expedition_select(1,2)
					doubleclick_send3() ; send the fleet!
					Timer("Expedition_3",1800000) ; set for 30 minutes 
					}
				GuiControlGet 2Expchoicefleet3
				if 2Expchoicefleet3 = 1 
					{
					DebugLog("Fleet 3 is going to expedition 3.`n")
					expedition_select(1,3)
					doubleclick_send3() ; send the fleet!
					Timer("Expedition_3",1200000) ; set for 20 minutes 
					}
				GuiControlGet 3Expchoicefleet3
				if 3Expchoicefleet3 = 1 
					{
					DebugLog("Fleet 3 is going to expedition 5.`n")
					expedition_select(1,5)
					doubleclick_send3() ; send the fleet!
					Timer("Expedition_3",5400000) ; set for 90 minutes 
					}
				GuiControlGet 4Expchoicefleet3
				if 4Expchoicefleet3 = 1 
					{
					DebugLog("Fleet 3 is going to expedition 6.`n")
					expedition_select(1,6)
					doubleclick_send3() ; send the fleet!
					Timer("Expedition_3",2400000) ; set for 40 minutes 
					}
				GuiControlGet 5Expchoicefleet3
				if 5Expchoicefleet3 = 1 
					{
					custom_send3()
					}
				}

			if (flag_sendfleet4 = 1 and expedition_screen_check() = 1) {
				GuiControlGet 1Expchoicefleet4
				if 1Expchoicefleet4 = 1 
					{
					DebugLog("Fleet 4 is going to expedition 2.`n")
					expedition_select(1,2)
					doubleclick_send4() ; send the fleet!
					Timer("Expedition_4",1800000) ; set for 30 minutes 
					}
				GuiControlGet 2Expchoicefleet4
				if 2Expchoicefleet4 = 1 
					{
					DebugLog("Fleet 4 is going to expedition 3.`n")
					expedition_select(1,3)
					doubleclick_send4() ; send the fleet!
					Timer("Expedition_4",1200000) ; set for 20 minutes 
					}
				GuiControlGet 3Expchoicefleet4
				if 3Expchoicefleet4 = 1 
					{
					DebugLog("Fleet 4 is going to expedition 5.`n")
					expedition_select(1,5)
					doubleclick_send4() ; send the fleet! 
					Timer("Expedition_4",5400000) ; set for 90 minutes 
					}
				GuiControlGet 4Expchoicefleet4
				if 4Expchoicefleet4 = 1 
					{
					DebugLog("Fleet 4 is going to expedition 6.`n")
					expedition_select(1,6)
					doubleclick_send4() ; send the fleet! 
					Timer("Expedition_4",2400000) ; set for 40 minutes 
					}
				GuiControlGet 5Expchoicefleet4
				if 5Expchoicefleet4 = 1
					{
					custom_send4()
					}
				}		
		}
		DebugLog("All requested fleets sent!`n")
		rand_sleep(500,1500) 
		Rand_ControlClick(11,55,90,125) ;; click home button 
		flag_sendexpedition := 0 ; all fleets sent!
	}

expedition_select(Byref wn, Byref en) { ;; fixed for yuubari
	; world number, expedition number
	rand_sleep(500,1500) 
	if wn = 1
		{
		Rand_ControlClick(127,475,157,491) 
		}
	else if wn = 2 
		{
		Rand_ControlClick(194,473,218,494)
		}
	else if wn = 3
		{
		Rand_ControlClick(247,472,281,493)
		}
	else if wn = 4
		{
		Rand_ControlClick(303,473,333,493)
		}
	else if wn = 5
		{
		Rand_ControlClick(358,475,392,494)
		}
	rand_sleep(500,1500) ; world selected pause a bit 
	; searches based on expedition order on respective lists 
	if en = 1
		{
		Rand_ControlClick(147,210,528,229)
		}
	else if en = 2
		{
		Rand_ControlClick(148,242,536,260)
		}
	else if en = 3
		{
		Rand_ControlClick(134,270,540,290)
		}
	else if en = 4
		{
		Rand_ControlClick(134,300,542,320)
		}
	else if en = 5
		{
		Rand_ControlClick(134,330,552,350)
		}
	else if en = 6
		{
		Rand_ControlClick(131,360,549,380)
		}
	else if en = 7
		{
		Rand_ControlClick(128,390,549,410)
		}
	else if en = 8
		{
		Rand_ControlClick(130,420,548,440)
		}
	rand_sleep(2500,5000) ; pause a bit before sending
	}
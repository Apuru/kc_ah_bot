; everything related to automation in here 

;
; there are a bunch of problems with complete automation. namely the first check and timers. perhaps ask user to input the time left on current expeditions?
;


; some globals 
global flag_runloop := 0 ; run loop flag

; not used
global flag_expedition_2_back := 0 ; expedition automation flags, theyre back 
global flag_expedition_3_back := 0
global flag_expedition_4_back := 0
global expedition_2_timer := 0 ; the timers
global expedition_3_timer := 0
global expedition_4_timer := 0

; used
global flag_auto2 := 0 ; resupply + resend needed 
global flag_auto3 := 0
global flag_auto4 := 0

global flag_require_repair := 0 ; for 2-3 farming automation 

; safe to send, not used atm 
; global flag_safetosend ; if its safe to send an expedition > no claim screen after resupplying 



; functions
	
expedition_prepare_automation() { ; prepare the expeditions (if back) and for resupplying

	if (home_screen_check_expedition() = 1) { ; 
		DebugLog("Found expedition screen. Claiming loots first.`n")
		expedition_claim()
		Rand_Sleep(10000,30000) ; need a long wait for timers to finish
		}	
		
	if Timer("Expedition_2") = True
		{
		flag_expedition_2_back := 1
		flag_auto2 := 1
		} 
		
	if Timer("Expedition_3") = True
		{
		flag_expedition_3_back := 1
		flag_auto3 := 1
		} 

	if Timer("Expedition_4") = True 
		{
		flag_expedition_4_back := 1
		flag_auto4 := 1
		} 
		
	}
	
	/*
expedition_prepare_automation_40s() { ; prepare the expeditions (if back) and for resupplying

	if Timer("Expedition_2") = True
		{
		flag_expedition_2_back := 1
		flag_auto2 := 1
		} else if Timer("Expedition_2") < 40000
			{
			flag_expedition_2_back := 1
			flag_auto2 := 1
			}
		
	if Timer("Expedition_3") = True
		{
		flag_expedition_3_back := 1
		flag_auto3 := 1
		} else if Timer("Expedition_3") < 40000
			{
			flag_expedition_3_back := 1
			flag_auto3 := 1
			}

	if Timer("Expedition_4") = True 
		{
		flag_expedition_4_back := 1
		flag_auto4 := 1
		} else if Timer("Expedition_4") < 40000
			{
			flag_expedition_4_back := 1
			flag_auto4 := 1
			}
	}
	*/
	
expedition_complete_check() { ; function to check if expedition timers are complete 
	if (flag_expedition_2_back = 1 OR flag_expedition_3_back = 1 OR flag_expedition_4_back = 1) {
		return 1
		} else {
		return 0 
		}
	}
	
automation_autosend() { ; a copy of the ClaimResSend except for automation purposes (auto_send)
	loop {
		exp_claim() ; claims 
		Rand_Sleep(1000,3000)
		; resupply start
		DebugLog("Clicking resupply button.`n")
		Rand_ControlClick(62,244,106,292) ;; home resupply 
		Rand_Sleep(2500,5000)
		
		if (flag_auto2 = 1) {
			DebugLog("Resupplying fleet 2.`n")
			Rand_ControlClick(178,161,188,172) ;; click fleet 2
			Rand_Sleep(2500,5000)
			selectall_resup()
			resupply_checker()
			flag_sendfleet2 := 1
			}
		if (flag_auto3 = 1) {
			DebugLog("Resupplying fleet 3.`n")
			Rand_ControlClick(209,160,219,172) ;; click fleet 3
			Rand_Sleep(2500,5000)
			selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
			resupply_checker()
			flag_sendfleet3 := 1
			}
		if (flag_auto4 = 1) {
			DebugLog("Resupplying fleet 4.`n")
			Rand_ControlClick(237,159,249,172) ;; click fleet 4
			Rand_Sleep(2500,5000)
			selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
			resupply_checker()
			flag_sendfleet4 := 1
			}
			
		Rand_ControlClick(11,55,90,125) ;; click home button
		Rand_Sleep(5000,7000) ; increased to compensate without the home check
		
		if (home_screen_check_expedition() = 1) { ; claim loot and restart resupply
			DebugLog("Expedition returned screen detected.`n")
			Sleep 500
			DebugLog("Resupply again (RA) function activated.`n")
			expedition_claim()
			if (Timer("Expedition_2","L") < 40000 and flag_sendfleet2 = 0) { ; the second flag check is to see if we've resupplied already 
				flag_auto2 := 1 
				}
			if (Timer("Expedition_3","L") < 40000 and flag_sendfleet3 = 0) { ; the second flag check is to see if we've resupplied already 
				flag_auto3 := 1 
				}
			if (Timer("Expedition_4","L") < 40000 and flag_sendfleet4 = 0) { ; the second flag check is to see if we've resupplied already 
				flag_auto4 := 1 
				}
			Rand_Sleep(3000,5000)
			DebugLog("(RA) Clicking resupply button.`n")
			Rand_ControlClick(62,244,106,292) ;; home resupply, also prevents the break from happening
			Rand_Sleep(5000,8000)
			}
		if (home_screen_check() = 1) { ; its safe to send 
			DebugLog("Its safe to send, sending.`n")
			flag_sendexpedition := 1 ; start send expedition flag
			break
			}
		}
		send_expedition() ; this can be found in the expeditions.ahk
		Rand_Sleep(500,2000)
		
	return
	}
	
	/*
automation_resupply_only() {
	DebugLog("Clicking resupply button.`n")
	ControlClick, x85 y527, KanColleViewer!,, LEFT, 1, NA Pos 
	Rand_Sleep(2500,5000)
	
	if (flag_auto2 = 1) {
		DebugLog("Resupplying fleet 2.`n")
		ControlClick, x183 y426, KanColleViewer!,, LEFT, 1, NA Pos ; click fleet 2 
		Rand_Sleep(2500,5000)
		selectall_resup()
		flag_sendfleet2 := 1
		}
	
	if (flag_auto3 = 1) {
		DebugLog("Resupplying fleet 3.`n")
		ControlClick, x215 y427, KanColleViewer!,, LEFT, 1, NA Pos ; click fleet 3 
		Rand_Sleep(2500,5000)
		selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
		flag_sendfleet3 := 1
		}
	if (flag_auto4 = 1) {
		DebugLog("Resupplying fleet 4.`n")
		ControlClick, x245 y426, KanColleViewer!,, LEFT, 1, NA Pos ; click fleet 4 
		Rand_Sleep(2500,5000)
		selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
		flag_sendfleet4 := 1
		}
	return
	}
	*/
	
	
automation_first_check() { ; first check to set the proper times, else timers are set on default expeditions on their respective category
	if (Timer("Expedition_2","L") > 0 and Timer("Expedition_3","L") > 0 and Timer("Expedition_4","L") > 0 ) {
		DebugLog("All fleets have timers!`n")
		DebugLog("Bot is active!`n")
		} else {
	exp_claim()
	Rand_Sleep(1000,3000)
	resupply()
	
	GuiControlGet Fleet_2 ; grabs the associated number 
	if Fleet_2 = 1 
		{ ; fleet 2   
		DebugLog("Send fleet 2 on expedition received!`n")
		flag_sendfleet2 := 1 ; send fleet 2 flag 
		} else if (Timer("Expedition_2","L") > 0) {
			DebugLog("Fleet 2 already has a timer.`n")
			} else {
			DebugLog("Setting default (90min) timer for Fleet 2.`n")
			Timer("Expedition_2",5400000) ; set for 90 minutes since we dont know whats going on with fleet 2
			}
	GuiControlGet Fleet_3 ; grabs the associated number 
	if Fleet_3 = 1 
		{ ; fleet 3 
		DebugLog("Send fleet 3 on expedition received!`n")
		flag_sendfleet3 := 1 ; send fleet 3 flag 
		} else if (Timer("Expedition_3","L") > 0) {
			DebugLog("Fleet 3 already has a timer.`n")
			} else {
			DebugLog("Setting default (30min) timer for Fleet 3.`n")
			Timer("Expedition_3",1800000) ; set for 30 minutes since we dont know whats going on with fleet 3
			}
	GuiControlGet Fleet_4 ; grabs the associated number 
	if Fleet_4 = 1 
		{ ; fleet 4 
		DebugLog("Send fleet 4 on expedition received!`n")		
		flag_sendfleet4 := 1 ; send fleet 3 flag 
		} else if (Timer("Expedition_4","L") > 0) {
			DebugLog("Fleet 4 already has a timer.`n")
			} else {
			DebugLog("Setting default (40min) timer for Fleet 4.`n")
			Timer("Expedition_4",2400000) ; set for 40 minutes since we dont know whats going on with fleet 3
			}
	if flag_sendexpedition = 0 
		{
		Rand_Sleep(2000,4000)
		flag_sendexpedition := 1 ; start send expedition flag
		send_expedition() 
		Rand_Sleep(500,2000)
		}
	}
	return
	}
	
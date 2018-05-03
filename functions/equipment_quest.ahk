do_equipment_quest() {
	return_home()
	get_to_quest_page()
	
	if (scan_eq_quest() = 1) { ; if its the first quest 
		DebugLog("Quest 1`n")
		click_quest(1)
		return_home() ; return home
		Rand_Sleep(2500,5000)
		Rand_ControlClick(252,387,302,437) ; click workshop 
		Rand_Sleep(2500,5000)
		
		; unique shit starts here ,, quest 1 
		Rand_ControlClick(143,364,318,409) ; click craft equipment 
		Msgbox, Set recipe now. ; perhaps add options to message box for recipes? 
		Rand_Sleep(2000,3000)	
		Rand_ControlClick(648,476,781,507) ; craft it!
		Rand_Sleep(8000,12000)
		Rand_ControlClick(344,312,585,513) ; retrieve item 
		
		; turn in the quest
		get_to_quest_page()
		click_quest(1)
		Rand_Sleep(1500,3000)	
		Rand_ControlClick(359,439,455,461) ; claim items 
		Rand_Sleep(3000,5000)	
		}
		
	if (scan_eq_quest() = 2) { ; second quest m8
		DebugLog("Quest 2`n")
		click_quest(2)
		return_home() ; return home 
		Rand_Sleep(1500,3000)
		Rand_ControlClick(252,387,302,437) ; click workshop 
		Rand_Sleep(1500,3000)
		
		; unique shit starts here ,, quest 2 
		; we need to click the shit out of all the crafted ships if there are any 
		claim_slots()
		; alright so we've claimed them all right?		
		Rand_Sleep(1500,3000)		
		Rand_ControlClick(581,210,660,249) ; click slot 1  			
		Rand_Sleep(2500,5000)
		Rand_ControlClick(646,472,783,507) ; click craft ship
		Rand_Sleep(3000,5000)
		
		; turn in the quest
		get_to_quest_page()
		click_quest(2)
		Rand_Sleep(1500,3000)	
		Rand_ControlClick(359,439,455,461) ; claim items 
		Rand_Sleep(3000,5000)	
		}
		
	if (scan_eq_quest() = 3) { ; third quest nigga  
		DebugLog("Quest 3`n")
		click_quest(3)
		; maybe we need a fail check? 
		return_home() ; return home
		Rand_Sleep(1500,3000)
		Rand_ControlClick(252,387,302,437) ; click workshop 
		Rand_Sleep(1500,3000)
		
		; unique shit starts here ,, quest 3 
		Rand_ControlClick(143,364,318,409) ; click craft equipment 
		Msgbox, Set recipe now. ; perhaps add options to message box for recipes? 
		Rand_Sleep(2000,3000)	
		Rand_ControlClick(648,476,781,507) ; craft it!
		Rand_Sleep(8000,12000)
		Rand_ControlClick(344,312,585,513) ; retrieve item
		Rand_Sleep(8000,12000)		
		; craft 2 more times 
		Rand_ControlClick(143,364,318,409) ; click craft equipment 
		Rand_Sleep(8000,12000)	
		Rand_ControlClick(648,476,781,507) ; craft it!
		Rand_Sleep(8000,12000)
		Rand_ControlClick(344,312,585,513) ; retrieve item 
		Rand_Sleep(8000,12000)	
		Rand_ControlClick(143,364,318,409) ; click craft equipment 
		Rand_Sleep(8000,12000)
		Rand_ControlClick(648,476,781,507) ; craft it!
		Rand_Sleep(8000,12000)
		Rand_ControlClick(344,312,585,513) ; retrieve item 
		Rand_Sleep(8000,12000)	
		
		; turn in the quest
		get_to_quest_page()
		click_quest(3)
		Rand_Sleep(8000,12000)	
		Rand_ControlClick(359,439,455,461) ; claim items 
		Rand_Sleep(3000,5000)
		}
		
	if (scan_eq_quest() = 4) { ; 4th quest, craft 3 ships   
		DebugLog("Quest 4`n")
		click_quest(4)
		; maybe we need a fail check? 
		return_home() ; return home
		Rand_Sleep(1500,3000)
		Rand_ControlClick(252,387,302,437) ; click workshop 
		Rand_Sleep(1500,3000)
		
		claim_slots()
		; unique shit starts here ,, quest 4 
		Rand_ControlClick(562,284,660,330) ; claim slot 2  			
		Rand_Sleep(2000,3000)
		Rand_ControlClick(646,472,783,507) ; click craft ship
		Rand_Sleep(5000,8000)
		Rand_ControlClick(562,362,660,408) ; claim slot 3 		
		Rand_Sleep(2000,3000)
		Rand_ControlClick(646,472,783,507) ; click craft ship
		Rand_Sleep(5000,8000)
		Rand_ControlClick(581,445,670,482) ; claim slot 4 			
		Rand_Sleep(2000,3000)
		Rand_ControlClick(646,472,783,507) ; click craft ship
		Rand_Sleep(5000,8000)
		
		; turn in the quest
		get_to_quest_page()
		click_quest(4)
		Rand_Sleep(2000,3000)	
		Rand_ControlClick(359,439,455,461) ; claim items 
		Rand_Sleep(3000,5000)
		}
	
	if (scan_eq_quest() = 5) { ; 5th quest, scrap 2 
		DebugLog("Quest 5`n")
		click_quest(5)
		; maybe we need a fail check? 
		return_home() ; return home
		Rand_Sleep(1500,3000)
		Rand_ControlClick(252,387,302,437) ; click workshop 
		Rand_Sleep(1500,3000)
		
		; unique shit starts here ,, quest 5 
		Rand_ControlClick(162,279,306,329) ; click scrap 
		Msgbox, Scrap 2 
		
		; turn in the quest
		get_to_quest_page()
		click_quest(5)
		Rand_Sleep(1500,3000)	
		Rand_ControlClick(359,439,455,461) ; claim items 
		Rand_Sleep(3000,5000)	
		}	
		
	if (scan_eq_quest() = 6) { ; 6th quest, modernize equipment
		DebugLog("Quest 6`n")
		click_quest(6)
		; maybe we need a fail check? 
		Rand_Sleep(5000,8000)
		return_home() ; return home
		Rand_Sleep(5000,8000)
		Rand_ControlClick(181,156,227,213) ; click organize  
		Rand_Sleep(5000,8000)
		
		; unique shit starts here ,, quest 6 
		Rand_ControlClick(383,253,442,274) ; click first ship girl  
		Msgbox, Modernize Equipment 
		
		; turn in the quest
		get_to_quest_page()
		click_quest(6)
		Rand_Sleep(1500,3000)	
		Rand_ControlClick(359,439,455,461) ; claim items 
		Rand_Sleep(3000,5000)	
		}	
		
	DebugLog("All done!`n")
	} ; end of macro do_equipment_quest 
	
get_to_quest_page() { 
	Rand_Sleep(1500,3000)
	Rand_ControlClick(538,86,589,108) ; click quests 
	Rand_ControlClick(538,86,589,108) ; click quests
	Rand_Sleep(3500,5000)
	Rand_ControlClick(344,312,585,513) ; get rid of Ooyodo
	Rand_Sleep(2500,5000)
	Rand_ControlClick(23,233,114,250) ; click day dailies
	Rand_Sleep(2500,5000)
	}
	
scan_eq_quest() { ; scans for which quest we're on 
	; DebugLog("Scanning which quest we're on..`n")
	ImageSearch, eqX, eqY, -1672, 46, -875, 528, images/eq_quest1.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		; DebugLog("Quest 1`n")
		return 1 
		} 
	ImageSearch, eqX, eqY, -1672, 46, -875, 528, images/eq_quest11.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		; DebugLog("Quest 1`n")
		return 1 
		} 
		
	ImageSearch, eqX, eqY, -1672, 46, -875, 528, images/eq_quest2.bmp ; searches for the second quest 
		if (ErrorLevel = 0) {
		; DebugLog("Quest 2`n")
		return 2 
		} 
		
	ImageSearch, eqX, eqY, -1672, 46, -875, 528, images/eq_quest3.bmp 
		if (ErrorLevel = 0) {
		; DebugLog("Quest 3`n")
		return 3
		} 
		
	ImageSearch, eqX, eqY, -1672, 46, -875, 528, images/eq_quest4.bmp 
		if (ErrorLevel = 0) {
		; DebugLog("Quest 4`n")
		return 4
		} 
		
	ImageSearch, eqX, eqY, -1672, 46, -875, 528, images/eq_quest5.bmp 
		if (ErrorLevel = 0) {
		; DebugLog("Quest 5`n")
		return 5
		} 
		
	ImageSearch, eqX, eqY, -1672, 46, -875, 528, images/eq_quest6.bmp 
		if (ErrorLevel = 0) {
		; DebugLog("Quest 6`n")
		return 6 
		} 	
	}
	
click_quest(qnum) {
Rand_Sleep(1500,3000)
Coordmode Pixel
; slot 1
ImageSearch, eqX, eqY, -1540,124, -1674, 20, images/eq_quest%qnum%.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		Rand_ControlClick(216,166,704,214) ; click slot 1 
		} 
; slot 2 
ImageSearch, eqX, eqY, -1538,190, -900,292, images/eq_quest%qnum%.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		Rand_ControlClick(217,236,703,282) ; click slot 2 
		} 
; slot 3 
ImageSearch, eqX, eqY, -1536,260, -901,360, images/eq_quest%qnum%.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		DebugLog("Click Q1`n")
		Rand_ControlClick(218,301,704,350) ; click slot 3 
		} 
; slot 4 
ImageSearch, eqX, eqY, -1542,326, -903,429, images/eq_quest%qnum%.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		Rand_ControlClick(217,371,702,419) ; click slot 4 
		} 
; slot 5 
ImageSearch, eqX, eqY, -1541,397, -902,497, images/eq_quest%qnum%.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		Rand_ControlClick(216,436,699,488) ; click slot 5 
		} 
; slot 5 // duplicate, seeing as only slot 5 is being used right now 
ImageSearch, eqX, eqY, -1541,397, -902,497, images/eq_quest%qnum%%qnum%.bmp ; searches for the first quest 
		if (ErrorLevel = 0) {
		Rand_ControlClick(216,436,699,488) ; click slot 5 
		} 
Rand_Sleep(4000,10000)
}
	
return_home() {
	if (home_screen_check() = 0) { ; if we're not on the homescreen, lets try and go there.
		Rand_ControlClick(11,55,90,125) ;; click home button 
		Rand_Sleep(6000,9000)
		if (home_screen_check_expedition() = 1) { ; claim loot
			DebugLog("Expedition returned screen detected.`n")
			expedition_claim()
			Rand_Sleep(5000,8000)
			}
		}  
	}
	
claim_slots() {
	Rand_Sleep(1000,3000)
	DebugLog("Claiming Slots. If any.`n")	
	Rand_Sleep(1000,3000)
	
	PixelSearch, csx, csy, -1123,229, -995,262, 0x333333,,Fast
		if (ErrorLevel = 0) {
		DebugLog("Claiming Slot 1`n")	
		Rand_ControlClick(581,210,660,249) ; claim slot 1 
		Rand_Sleep(8000,10000)
		Rand_ControlClick(581,210,660,249) ; claim slot 1 
		Rand_Sleep(3000,5000)
		} 
	Rand_Sleep(1000,3000)
	; slot 2 check 
	PixelSearch, csx, csy, -1126,312, -988,349, 0x333333,,Fast
		if (ErrorLevel = 0) {
		DebugLog("Claiming Slot 2`n")
		Rand_ControlClick(562,284,660,330) ; claim slot 2 
		Rand_Sleep(8000,10000)
		Rand_ControlClick(562,284,660,330) ; claim slot 2 
		Rand_Sleep(3000,5000)
		} 
	Rand_Sleep(1000,3000)
	; slot 3 check 
	PixelSearch, csx, csy, -1128,387, -984,421, 0x333333,,Fast
		if (ErrorLevel = 0) {
		DebugLog("Claiming Slot 3`n")
		Rand_ControlClick(562,362,660,408) ; claim slot 3 
		Rand_Sleep(8000,10000)
		Rand_ControlClick(562,362,660,408) ; claim slot 3 
		Rand_Sleep(3000,5000)
		} 
	Rand_Sleep(1000,3000)
	; slot 4 check 
	PixelSearch, csx, csy, -1131,463, -980,506, 0x333333,,Fast
		if (ErrorLevel = 0) {
		DebugLog("Claiming Slot 4`n")
		Rand_ControlClick(581,445,670,482) ; claim slot 4 
		Rand_Sleep(8000,10000)
		Rand_ControlClick(581,445,670,482) ; claim slot 4 
		Rand_Sleep(3000,5000)
		} 
		
	Rand_Sleep(1000,3000)
	}
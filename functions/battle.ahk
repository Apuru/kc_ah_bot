; battle related functions
; my attempt to standardize all missions, to make writing macros for them easier and require little modification
; includes a damage checker! (although unreliable) 
;
; by Applejack 2015-05-18

global flag_retreat 

; flag for knowing we selected formation 
global flag_formationselected

; counter for clicking the screen 
global click_counter
global click_counter_escape

; flag for resupplying fleet 1
; set in mission select, queried in battle and incremented in the first resupply
global flag_resupply_fleet_1 

trigger_compass() {
	Rand_Sleep(2500,5000)
	;DebugLog("Triggering compass.`n")
	Rand_ControlClick(264,144,548,417) ;; trigger compass 
	Sleep 100
	Rand_ControlClick(264,144,548,417) ;; trigger compass 
	Rand_Sleep(3000,6000) ; 10s to next click (at least)
	}
	
trigger_clearscreen() {
	Rand_ControlClick(349,352,737,498) ;; trigger clear screen (not within range of pursuit or no pursuit buttons)
	Sleep 100
	Rand_ControlClick(349,352,737,498) ;; trigger clear screen (not within range of pursuit or no pursuit buttons)
	Rand_Sleep(3000,6000)
	}
	
new_sub() { ; do we want to swap subs out?
	GuiControlGet SelectNewSub ; get the new sub box
		if SelectNewSub = 1 
		{
		flag_sannia_sortie := 1
		return 1 ; true, get new sub
		} else {
		return 0 ; false, dont get new sub
		}
	}
	
damage_check() { ; Checks if the current screen is the home screen with expedition complete  
	; note: variation shades don't seem to be working with this one
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, damageX, damageY, -1680, 0, -1302, 740, images/damagedai_1.bmp ; searches for red text 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_1.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_2.bmp ; searches for red text 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_2.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_3.bmp ; searches for red text 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_3.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_4.bmp ; i think this is the most important one
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_4.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_5.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_5.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_6.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_6.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_7.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_7.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_8.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_8.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_9.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_9.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_10.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_10.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_11.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_11.bmp found`n")
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_12.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		DebugLog("damagedai_12.bmp found`n")
		} 	

		if (damagescreen_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
damage_check_full() { ; checks for tai ha ship girl before sorting
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, damageX, damageY, -1680, 0, 0, 1000, images/damagedai_1.bmp ; searches for red text 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_2.bmp ; searches for red text 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_3.bmp ; searches for red text 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_4.bmp ; i think this is the most important one
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_5.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_6.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_7.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_8.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_9.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, 0, 1000, images/damagedai_10.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_11.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
	ImageSearch, damage2X, damage2Y, -1680, 0, -1302, 740, images/damagedai_12.bmp 
		if (ErrorLevel = 0) {
		damagescreen_ok := 1 
		} 	
		if (damagescreen_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
kcv_damage_check() { ; search kcv for critically damaged ships 
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	PixelSearch red_x, red_y, -745, 98, -522, 328, 0x2020FF, 2, fast
	if (ErrorLevel = 0) {
		return 1
		} else {
		return 0
		}
	}
	
crit_check() {
	if (kcv_damage_check() = 1) {
		SoundBeep
		SoundBeep
		SoundBeep
		SoundBeep
		SoundBeep
		Msgbox, Critically damaged ship detected!!`nBot will now exit.
		ExitApp
		} else {
		return
		}
	}
	
retreat() { ; full retreat!
	DebugLog("Initiating retreat script.`n")
	; flag_retreat := 1 ; don't reloop 3-2-A
	
	while (nightbattle_check() = 0 and victory_check() = 0) {
		Sleep 2000 ; sleep for a bit and check again
		}
		
	if (nightbattle_check() = 1) {
		DebugLog("Retreat Mode: Night battle option detected...`n")
		Rand_Sleep(3000,5000)
		DebugLog("Retreat Mode: No night battle.`n")
		Rand_ControlClick(265,262,331,313) ;; no night battle 
		Rand_Sleep(12000, 20000) ; wait for victory screen 
		} 
	DebugLog("Retreat Mode: Waiting for victory screen.`n")
	while (victory_check() = 0) {
		Sleep 2000
		}
	
	if (victory_check() = 1) {
		DebugLog("Retreat Mode: Victory screen detected...`n")
		Sleep 5000
		}
		
	while (home_screen_check() = 0 and home_screen_check_expedition() = 0) {
		DebugLog("Retreat!!`n")
		Rand_ControlClick(477,264,550,316) ;; end mission 
		Rand_Sleep(3000,5000)
		}
		
		Rand_Sleep(8000,10000)
		if (home_screen_check_expedition() = 1) { ; claim loot
			DebugLog("Expedition returned screen detected.`n")
			expedition_claim()
			Rand_Sleep(5000,8000)
			}
		if (home_screen_check() = 1) { ; resupply fleet 1 
			DebugLog("Resupplying fleet 1.`n")
			Rand_ControlClick(62,244,106,292) ;; home resupply 
			Rand_Sleep(3500,6000)
			selectall_resup() ; 
			}
		if (sidebar_check() = 1) {
			DebugLog("Repairing critically damaged ship.`n")
			Rand_ControlClick(15,345,39,378) ;; click side repair button 
			Rand_Sleep(3500,6000)
			repair()
			end_san_ni_a_check() ; check if we have any repair slots, if no then we will end 
			; mainly for 3-2-A, feel free to replace with a return home click or something. maybe make a flag for it?
			}
		if (sidebar_check() = 1 AND flag_sannia_sortie = 1 AND flag_subneedsreplacing = 1) { 
			Rand_Sleep(3000,5000)
			Rand_ControlClick(15,182,41,216) ;; click side organize
			Rand_Sleep(3000,5000) 
			Rand_ControlClick(727,481,784,500) ;; click last kanmusu
			Rand_Sleep(3000,5000) 
			if (new_sub() = 1) { ; do we want to replace this sub?
				DebugLog("Using select_new_sub function.`n")
				select_new_sub() ; select a new sub (found in repair.ahk)
				} else {
				flag_retreat := 1
				}
			}
	return
	}
	
	
mission_select(Byref wv,Byref lv) { ; wv = world value, lv = level value
	if (home_screen_check() = 0) { ; if we're not on the homescreen, lets try and go there.
		Rand_ControlClick(11,55,90,125) ;; click home button 
		Rand_Sleep(6000,9000)
		if (home_screen_check_expedition() = 1) { ; claim loot
			DebugLog("Expedition returned screen detected.`n")
			expedition_claim()
			Rand_Sleep(5000,8000)
			}
		}  
	Rand_ControlClick(167,269,240,346) ;; shutsugeki button 
	Rand_Sleep(2500,5000)
	crit_check() 
	Rand_ControlClick(180,216,299,320) ;; select missions 
	Rand_Sleep(4500,6000)
	crit_check() 
		if wv = 1 
			{
			}
		else if wv = 2 
			{
			Rand_ControlClick(216,472,264,502) ;; select world 2
			}
		else if wv = 3 
			{
			Rand_ControlClick(295,479,339,501) ;; select world 3
			}
		else if wv = 4 
			{
			Rand_ControlClick(365,476,406,500) ;; select world 4
			}
		else if wv = 5
			{
			Rand_ControlClick(435,472,483,499) ;; select world 5
			}
		else if wv = 6
			{
			Rand_ControlClick(510,484,561,500) ;; select world 6
			}
		else if wv = 9
			{
			Rand_ControlClick(685,474,770,511) ;; select seasonal event
			}
	Rand_Sleep(2500,5000)
		if lv = 1 
			{
			Rand_ControlClick(147,200,433,306) ;; select level 1 
			}
		else if lv = 2 
			{
			Rand_ControlClick(476,196,655,310) ;; select level 2 
			}
		else if lv = 3 
			{
			Rand_ControlClick(148,344,424,447) ;; select level 3 
			}
		else if lv = 4 
			{
			Rand_ControlClick(478,339,683,452) ;; select level 4 
			}	
		else if lv = 5 
			{
			Rand_ControlClick(699,297,748,345) ;; select level 5 1/2
			Rand_Sleep(2500,5000)
			Rand_ControlClick(185,199,760,306) ;; select level 5 2/2
			}
		else if lv = 6 
			{
			Rand_ControlClick(699,297,748,345) ;; select level 5 1/2
			Rand_Sleep(2500,5000)	
			Rand_ControlClick(196,339,750,446) ;; select level 6 2/2
			}
		else if lv = 91 
			{
			Rand_ControlClick(360,193,756,264) ;; select event level 1
			Rand_Sleep(2500,5000)
			Rand_ControlClick(256,157,713,410) ; click green board
			Rand_Sleep(2500,5000)
			Rand_ControlClick(256,157,713,410) ; click green board
			}
	crit_check() 
	Rand_Sleep(2500,5000)			
	Rand_ControlClick(656,477,728,506) ;; send 1/2 
	crit_check() 
	Rand_Sleep(2500,5000)	
	if (damage_check_full() = 1) ; one last damage check 
		{
		
		SoundBeep
		SoundBeep
		SoundBeep
		SoundBeep
		SoundBeep
		MsgBox, Warning!! Critically damaged ship detected!!!`nBot will now exit.
		ExitApp
		}
	crit_check() 
	Rand_ControlClick(569,476,703,508) ;; send 2/2 
	flag_resupply_fleet_1 := 0 ; we're off to sortie!
	Rand_Sleep(6000,10000) 
	}
	
battle(Byref fv,Byref nv,Byref pv) { ; 0 for no, 1 for yes || format is (formation y/n, night battle y/n, pursuit y/n)
	flag_retreat := 0 ; we've just started, no retreat required
	flag_formationselected := 0 ; formation hasnt been selected yet 
	click_counter := 0 ; for those pesky screens with resources 
	click_counter_escape := 0 ; when we clicked, we will break 

	DebugLog("Battle started!.`n")
	while (flag_formationselected = 0 and home_screen_check() = 0 and home_screen_check_expedition() = 0) {
		Sleep 500 ; sleep for a bit and check again
		if (compass_check() = 1) {
			DebugLog("Compass detected, triggering.`n")
			trigger_compass()
			}
		if (formation_check() = 1) {
			DebugLog("Formation select screen detected.`n")
			Sleep 500
			Rand_Sleep(3000,5000)
			if fv = 0 
				{
				DebugLog("This battle requires no formation.`n")
				Rand_Sleep (500, 2000) ; wait for victory screen 
				flag_formationselected := 1
				}
			else if fv = 1 
				{
				DebugLog("Line Ahead formation.`n")
				Rand_ControlClick(409,224,497,243) ;; line ahead 
				flag_formationselected := 1
				Rand_Sleep (10000, 20000) ; wait for victory screen 
				}
			else if fv = 2 
				{
				DebugLog("Double Line formation.`n")
				Rand_ControlClick(540,224,627,243) ;; double line 
				flag_formationselected := 1
				Rand_Sleep (12000, 20000) ; wait for victory screen 
				}
			else if fv = 3
				{
				DebugLog("Diamond formation.`n")
				Rand_ControlClick(672,224,759,243) ;; diamond 
				flag_formationselected := 1
				Rand_Sleep (10000, 20000) ; wait for victory screen 
				}
			else if fv = 4 
				{
				DebugLog("Echelon formation.`n")
				Rand_ControlClick(479,382,564,400) ;; echelon 
				flag_formationselected := 1
				Rand_Sleep (12000, 20000) ; wait for victory screen 
				}
			else if fv = 5
				{
				DebugLog("Anti-submarine formation.`n")
				Rand_ControlClick(610,382,696,400) ;; anti-sub 
				flag_formationselected := 1
				Rand_Sleep (10000, 20000) ; wait for victory screen 
				}
			}
			
			if (nightbattle_check() = 1) { ; in case of no formation and night battle option is detected
				DebugLog("Night battle option detected...`n")
				Rand_Sleep(4000,6000)
				if nv = 0 
				{
				DebugLog("No night battle.`n")
				Rand_ControlClick(265,262,331,313) ;; no night battle 
				Rand_Sleep (12000, 20000) ; wait for victory screen 
				}
				else if nv = 1 
				{
				DebugLog("Yes night battle.`n")
				Rand_ControlClick(478,264,546,314) ;; yes night battle 
				Rand_Sleep (10000, 20000) ; wait for victory screen 
				}
				} 
			
			if (home_screen_check_expedition() = 1) { ; claim loot
				DebugLog("Expedition returned screen detected.`n")
				expedition_claim()
				Rand_Sleep(5000,8000)
				break
				}
				
			if (victory_check() = 1) { ; victory screen detected 
				break
				}
			
			if (flag_formationselected = 1) {
				break
				}
				
			if (click_counter >= 15 AND click_counter_escape < 2) {
				DebugLog("Click threshold reached!`n")
				Rand_ControlClick(349,352,737,498) ;; click somewhere where it wont click anything important 
					if (home_screen_check_expedition() = 1) { ; claim loot
					DebugLog("Expedition returned screen detected.`n")
					expedition_claim()
					Rand_Sleep(5000,8000)
					break
					}
				click_counter := 0
				click_counter_escape += 1
				Rand_Sleep(2000,5000)
				}
			
			if (click_counter_escape >= 2) {
				DebugLog("Refreshing for home screen.`n")
				Rand_ControlClick(11,55,90,125) ;; click home button 
				Rand_Sleep(4000,8000)
					if (home_screen_check_expedition() = 1) { ; claim loot
					DebugLog("Expedition returned screen detected.`n")
					expedition_claim()
					Rand_Sleep(5000,8000)
					break
					}
					if (home_screen_check() = 0) {
					Rand_ControlClick(11,55,90,125) ;; click home button again
					Rand_Sleep(4000,8000)
					}
				break
				return
				}
			click_counter += 1
		}
		
	if (home_screen_check() = 1 AND flag_resupply_fleet_1 = 0) {
		DebugLog("Home screen detected, battle ending early.`n")
		DebugLog("Resupplying fleet 1.`n")
		Rand_ControlClick(62,244,106,292) ;; home resupply 
		Rand_Sleep(3500,6000)
		selectall_resup() 
		flag_resupply_fleet_1 := 1 ; we resupplied once, don't need to resupply anymore
		Rand_ControlClick(11,55,90,125) ;; click home button 
		Rand_Sleep(6000,9000)
		return
		} else if (home_screen_check() = 1 AND flag_resupply_fleet_1 = 1){
			DebugLog("Home screen detected, battle ending early.`n")
			DebugLog("Resupplied already.`n")
			return
			}
		
	while (victory_check() = 0 AND damage_check() = 0 AND nightbattle_check() = 0) { ; victory must be first 
		Sleep 2000 ; sleep for a bit and check again
		}
	
	if (damage_check() = 1) { ; success
		DebugLog("Critically damaged ship detected!.`n")
		Soundbeep 
		; Msgbox, 0x40000, Warning!, Critical condition detected. ; 0x40000 is always on top 
		retreat()
		return
		}
		
	if (nightbattle_check() = 1) {
		DebugLog("Night battle option detected...`n")
		Rand_Sleep(4000,6000)
		night := %nv%
		if nv = 0 
			{
			DebugLog("No night battle.`n")
			Rand_ControlClick(265,262,331,313) ;; no night battle 
			Rand_Sleep (12000, 20000) ; wait for victory screen 
			}
		else if nv = 1 
			{
			DebugLog("Yes night battle.`n")
			Rand_ControlClick(478,264,546,314) ;; yes night battle 
			Rand_Sleep (10000, 20000) ; wait for victory screen 
			}
		} 
		
	DebugLog("Waiting for victory screen.`n")
	while (victory_check() = 0) {
		Sleep 2000
		if (nightbattle_check() = 1) {
		DebugLog("Night battle option detected...`n")
		Rand_Sleep(4000,6000)
		night := %nv%
		if nv = 0 
			{
			DebugLog("No night battle.`n")
			Rand_ControlClick(265,262,331,313) ;; no night battle 
			Rand_Sleep (12000, 20000) ; wait for victory screen 
			}
		else if nv = 1 
			{
			DebugLog("Yes night battle.`n")
			Rand_ControlClick(478,264,546,314) ;; yes night battle 
			Rand_Sleep (10000, 20000) ; wait for victory screen 
			}
		} 
		}
	Sleep 2000
	
	DebugLog("Victory screen detected...`n")
		Rand_Sleep (5000,8000)
		if (damage_check() = 0) {
			Rand_ControlClick(702,454,760,503) ;; click bottom right button
			Rand_Sleep (5000,8000)
			} else {
			DebugLog("Critically damaged ship detected. Pausing!.`n")
			Soundbeep
			; Msgbox, 0x40000, Warning!, Critical condition detected.
			retreat()
			return
			}
		if (damage_check() = 0) {
			Rand_ControlClick(702,454,760,503) ;; click bottom right button
			Rand_Sleep (5000,8000)
			} else {
			DebugLog("Critically damaged ship detected. Pausing!.`n")
			Soundbeep
			; Msgbox, 0x40000, Warning!, Critical condition detected.
			retreat()
			return
			}
		while (home_screen_check_expedition() = 0 and home_screen_check() = 0 and pursuit_check() = 0 and damage_check() = 0) { ; wait for pursuit screen or home screen 
			if (home_screen_check() = 0) {
				Rand_ControlClick(702,454,760,503) ;; click bottom right button in case we got a new kanmusu
				}
			Rand_Sleep (3000,5000) 
			}
			if (home_screen_check_expedition() = 1) { ; claim loot
				DebugLog("Expedition returned screen detected.`n")
				expedition_claim()
				Rand_Sleep(5000,8000)
				return
				}
			
			if (damage_check() = 1) {
				DebugLog("Critically damaged ship detected. Pausing!.`n")
				Soundbeep
				; Msgbox, 0x40000, Warning!, Critical condition detected.
				
				}
			if (pursuit_check() = 1) { ; check for pursuit or home screen + expedition check
				DebugLog("Pursuit screen detected...`n")
				Rand_Sleep(3000,5000) ; wait a bit after pursuit screen is found 
				if pv = 0 
					{
					DebugLog("End mission.`n")
					Rand_ControlClick(477,264,550,316) ;; end mission 
					Rand_Sleep (6000,9000)
					}
				if pv = 1 
					{
					DebugLog("Continue mission.`n")
					Rand_ControlClick(263,264,333,316) ;; continue mission 
					Rand_Sleep (6000,9000)
					}	
				}
		
		Rand_Sleep(8000,10000)
		
		if (home_screen_check_expedition() = 1) { ; claim loot
			DebugLog("Expedition returned screen detected.`n")
			expedition_claim()
			Rand_Sleep(5000,8000)
			return
			}
			
		if (home_screen_check_expedition() = 1) { ; claim loot
			DebugLog("Expedition returned screen detected.`n")
			expedition_claim()
			Rand_Sleep(5000,8000)
			return
			}
			
		if (home_screen_check() = 1) { ; resupply fleet 1 
			DebugLog("Resupplying fleet 1.`n")
			Rand_ControlClick(62,244,106,292) ;; home resupply 
			Rand_Sleep(3500,6000)
			selectall_resup() ;
			flag_resupply_fleet_1 := 1 ; we resupplied once, don't need to resupply anymore
			Rand_ControlClick(11,55,90,125) ;; click home button 
			Rand_Sleep(6000,9000)
			return
			}
				
			
		
	Sleep 1000
	}
;
;
; this is battle_check duplicated for the purposes of adding some extra checks, the previous is used because it has less checks and therfore faster. 
;
;
final_battle(Byref fv,Byref nv,Byref pv) { ; 0 for no, 1 for yes || format is (formation y/n, night battle y/n, pursuit y/n)
	if (home_screen_check() = 1) { ; if we're home it means we don't need to run this again
		Rand_Sleep(2000,5000)
		DebugLog("Home screen detected, f-battle ending early. Resup needed?`n")
		return
		}  
	DebugLog("Battle started!.`n")
	while (compass_check() = 0 and formation_check() = 0 and nightbattle_check() = 0 and victory_check() = 0 and home_screen_check() = 0 and clearscreen_check() = 0) {
			Sleep 2000 ; sleep for a bit and check again
			}
		if (compass_check() = 1) {
			DebugLog("Compass detected, triggering.`n")
			trigger_compass()
			}
		if (clearscreen_check() = 1) {
			trigger_clearscreen()
			return
			}
		if (home_screen_check() = 1) {
			DebugLog("Home screen detected, f-battle ending early. Resup needed?`n")
			return
			}
	
	while (damage_check() = 0 and formation_check() = 0 and compass_check() = 0 and nightbattle_check() = 0 and victory_check() = 0 and home_screen_check() = 0 and clearscreen_check() = 0) {
			Sleep 2000 ; sleep for a bit and check again
			}
		if (compass_check() = 1) { ; extra compass just in case of the double compass maps 
			DebugLog("Compass detected, triggering.`n")
			trigger_compass()
			}
		
		if (clearscreen_check() = 1) {
			trigger_clearscreen()
			DebugLog("Clear screen detected, f-battle ending early. Resup needed?`n")
			return
			}
		
		if (formation_check() = 1) {
			DebugLog("Formation select screen detected.`n")
			Rand_Sleep(3000,5000)
			if fv = 0 
				{
				DebugLog("This battle requires no formation.`n")
				Rand_Sleep (500, 2000) ; wait for victory screen 
				}
			else if fv = 1 
				{
				DebugLog("Line Ahead formation.`n")
				Rand_ControlClick(409,224,497,243) ;; line ahead
				Rand_Sleep (10000, 20000) ; wait for victory screen 
				}
			else if fv = 2 
				{
				DebugLog("Double Line formation.`n")
				Rand_ControlClick(540,224,627,243) ;; double line 
				Rand_Sleep (12000, 20000) ; wait for victory screen 
				}
			else if fv = 3
				{
				DebugLog("Diamond formation.`n")
				Rand_ControlClick(672,224,759,243) ;; diamond 
				Rand_Sleep (10000, 20000) ; wait for victory screen 
				}
			else if fv = 4 
				{
				DebugLog("Echelon formation.`n")
				Rand_ControlClick(479,382,564,400) ;; echelon 
				Rand_Sleep (12000, 20000) ; wait for victory screen 
				}
			else if fv = 5
				{
				DebugLog("Anti-submarine formation.`n")
				Rand_ControlClick(610,382,696,400) ;; anti-sub 
				Rand_Sleep (10000, 20000) ; wait for victory screen 
				}
			}
		
		if (home_screen_check() = 1) {
			return
			}
	
	while (victory_check() = 0 and damage_check() = 0 and nightbattle_check() = 0) { ; victory must be first 
		Sleep 2000 ; sleep for a bit and check again
		}
	
	if (damage_check() = 1) { ; success
		DebugLog("Critically damaged ship detected. Pausing!.`n")
		Soundbeep 
		; Msgbox, 0x40000, Warning!, Critical condition detected. ; 0x40000 is always on top 
		retreat()
		return
		}
		
	if (nightbattle_check() = 1) {
		DebugLog("Night battle option detected...`n")
		Rand_Sleep(3000,5000)
		night := %nv%
		if nv = 0 
			{
			DebugLog("No night battle.`n")
			Rand_ControlClick(265,262,331,313) ;; no night battle 
			Rand_Sleep (12000, 20000) ; wait for victory screen 
			}
		else if nv = 1 
			{
			DebugLog("Yes night battle.`n")
			Rand_ControlClick(478,264,546,314) ;; yes night battle 
			Rand_Sleep (10000, 20000) ; wait for victory screen 
			}
		} 
		
	DebugLog("Waiting for victory screen.`n")
	while (victory_check() = 0) {
		Sleep 2000
		}
	Sleep 2000
	DebugLog("Victory screen detected...`n")
		Rand_Sleep (5000,8000)
		if (damage_check() = 0) {
			Rand_ControlClick(702,454,760,503) ;; click bottom right button
			Rand_Sleep (5000,8000)
			} else {
			DebugLog("Critically damaged ship detected. Pausing!.`n")
			Soundbeep
			retreat()
			return
			}
		if (damage_check() = 0) {
			Rand_ControlClick(702,454,760,503) ;; click bottom right button
			Rand_Sleep (5000,8000)
			} else {
			DebugLog("Critically damaged ship detected. Pausing!.`n")
			Soundbeep
			retreat()
			return
			}
		while (pursuit_check() = 0 and home_screen_check_expedition() = 0 and home_screen_check() = 0 and damage_check() = 0) { ; wait for pursuit screen or home screen
			Rand_ControlClick(702,454,760,503) ;; click bottom right button
			Rand_Sleep (3000,5000) 
			}
			if (damage_check() = 1) {
				DebugLog("Critically damaged ship detected. Pausing!.`n")
				Soundbeep
				retreat()
				return
				}
			if (pursuit_check() = 1) { ; check for pursuit or home screen + expedition check
				DebugLog("Pursuit screen detected...`n")
				Rand_Sleep(3000,5000) ; wait a bit after pursuit screen is found 
				if pv = 0 
					{
					DebugLog("End mission.`n")
					Rand_ControlClick(477,264,550,316) ;; end mission 
					Rand_Sleep (6000,9000)
					}
				if pv = 1 
					{
					DebugLog("Continue mission.`n")
					Rand_ControlClick(263,264,333,316) ;; continue mission 
					Rand_Sleep (6000,9000)
					}	
				}
			Rand_Sleep(8000,10000)
			if (home_screen_check_expedition() = 1) { ; claim loot
				DebugLog("Expedition returned screen detected.`n")
				expedition_claim()
				Rand_Sleep(5000,8000)
				}
			if (home_screen_check() = 1) { ; resupply fleet 1 
				DebugLog("Resupplying fleet 1.`n")
				Rand_ControlClick(62,244,106,292) ;; home resupply 
				Rand_Sleep(3500,6000)
				selectall_resup() ; 
				Rand_ControlClick(11,55,90,125) ;; click home button 
				Rand_Sleep(6000,9000)
				return
				}
		
	Sleep 1000
	}	
	
ichi_ichi() { ; this assumes that everything is ready to be sent. other additional checks can be added later.
	DebugLog("Sortie 1-1. Launch!`n")
	mission_select(1,1)
	; 1-1-1	
	battle(1,0,1) ; line ahead formation, yes night, yes pursue
	; 1-1-2
	battle(1,0,1) ; line ahead formation, yes night (final battle does not have pursuit)
	return
	}
	
ichi_go() {
	DebugLog("Sortie 1-5. Launch!`n")
	mission_select(1,5)
	battle(5,0,1) ; anti-sub formation, no night, yes pursue
	battle(5,0,1)
	battle(5,0,1)
	battle(5,0,1)
	return
	}
	
ni_ichi() {
	DebugLog("Sortie 2-1. Launch!`n")
	mission_select(2,1)
	battle(1,1,1) ; line ahead formation, yes night, yes pursue
	battle(1,1,1)
	return
	}
	
ni_ni() {
	DebugLog("Sortie 2-2. Launch!`n")
	mission_select(2,2)
	battle(1,1,1) ; line ahead formation (if required), yes night, yes pursue
	battle(1,1,1)
	return
	}
	
nini_farm() {
	DebugLog("Sortie 2-2 (no night version). Launch!`n")
	mission_select(2,2)
	battle(1,0,1) ; line ahead formation (if required), no night, yes pursue
	battle(1,0,1)
	return
	}

ni_san() {
	Sleep 500
	DebugLog("Sortie 2-3. Launch!`n")
	Sleep 500
	mission_select(2,3)
	battle(1,1,1) ; line ahead formation, yes night, yes pursue
	battle(1,1,1)
	final_battle(1,1,1)
	return
	}

ni_san_farm() {
	Sleep 500
	DebugLog("Sortie 2-3. (no night version) Launch!`n")
	Sleep 500
	mission_select(2,3)
	battle(1,0,1) ; line ahead formation, yes night, yes pursue
	battle(1,0,1)
	battle(1,0,1)
	return
	}
	
ni_san_farm_worldboss() {
	Sleep 500
	DebugLog("Sortie 2-3. (world boss farm version) Launch!`n")
	Sleep 500
	mission_select(2,3)
	battle(1,0,1) ; line ahead formation, yes night, yes pursue
	battle(1,0,1)
	final_battle(1,1,1) ; yes night for world boss
	return
	}

san_ni_a() {
	DebugLog("Sortie 3-2-A. Launch!`n")
	mission_select(3,2)
	battle(1,0,0) ; line ahead formation, no night, no pursuit
	}
	
Go_yon() {
	DebugLog("Sortie 5-4. Launch!`n")
	mission_select(5,4)
	battle(1,0,1) ; line ahead formation, no night, yes pursuit
	battle(1,0,1)
	battle(1,0,1)
	battle(1,1,1) 
	}
	
E_ichi() {
	mission_select(9,91)
	battle(5,0,1)
	battle(1,0,1)
	battle(5,0,1)
	battle(1,0,1)
	battle(5,1,1)
	}



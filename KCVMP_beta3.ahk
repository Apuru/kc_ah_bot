;
; Applejack's Macro Panel! 
; 

; ideas:   
; quest do-er (slow reload/crafting)
; exercise (quest) do-er 
; crafting (quest) do-er 
; auto crafting
; <*nearly* done> 2-3 sub farming 
; <DONE!> 3-2-A farming
; auto repair  
; add queuing and priority 
; add a function to replace the if-home, go-back-to-home long list of lines 
; replacing many more long duplicate lines of code with functions 

; make it work on any computer with a config.ini and adaptable settings  

; Priority list: 
; - Adding order queuing
; - 100% AFK for expeditions, 3-2-A farm


;
; Variables = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
; 

global flag_sendexpedition := 0 
global flag_sendfleet2 := 0
global flag_sendfleet3 := 0
global flag_sendfleet4 := 0

global flag_sannia_sortie := 0 ; for maximum efficiency doing 3-2-A
global flag_retreat := 0

global flag_runloop


;
; Some Includes = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
; 

#include automation.ahk
#include GUI.ahk 
; #include functions/15farm.ahk ; old 1-5 farm (keeping it because it works) outdated. Replaced with standardized battles. 
; #include functions/32A.ahk ; old 3-2-A sortie (keeping it because it works but buggy). Replaced with standardized battles.
#include functions/battle.ahk ; battle related functions 
#include functions/expedition.ahk
#include functions/general_functions.ahk
#include functions/repair.ahk
#include functions/timer.ahk ; function timer for expedition automation
#include functions/equipment_quest.ahk 

;
; Functions = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
; 

;
; Buttons 
; 
	
; we are in need of resupplying. 
Resupneeded: 
	{
	resupply()
	return
	}
	
Expclaim:
	{
	exp_claim()
	return
	}

Retreat: 
	{ 
	retreat()
	return
	}

Repair:
	{
	repair()
	return
	}
	
Send_2:
	{
		DebugLog("Send fleet 2 on expedition received!`n")
		flag_sendfleet2 := 1 ; send fleet 2 flag 
		Gui, Submit, NoHide ; grab values from radio groups based on their position, only command that does such 
		if flag_sendexpedition = 0 
			{
			flag_sendexpedition := 1 ; start send expedition flag
			send_expedition() ; this can be found in the expeditions.ahk
			rand_sleep(500,2000)
			}
		return
	}

Send_3:
	{
		DebugLog("Send fleet 3 on expedition received!`n")
		flag_sendfleet3 := 1 ; send fleet 3 flag 
		Gui, Submit, NoHide ; grab values from radio groups based on their position, only command that does such 
		if flag_sendexpedition = 0 
			{
			flag_sendexpedition := 1 ; start send expedition flag
			send_expedition() ; this can be found in the expeditions.ahk
			rand_sleep(500,2000)
			}
		return
	}
	
Send_4:
	{
		DebugLog("Send fleet 4 on expedition received!`n")
		flag_sendfleet4 := 1 ; send fleet 4 flag 
		Gui, Submit, NoHide ; grab values from radio groups based on their position, only command that does such 
		if flag_sendexpedition = 0 
			{
			flag_sendexpedition := 1 ; start send expedition flag
			send_expedition() ; this can be found in the expeditions.ahk
			rand_sleep(500,2000)
			}
		return
	} 

Sannia: ; sortie 3-2-A 
	{
	san_ni_a()
	
	loop {
	
		if (flag_retreat = 0) {
			DebugLog("No damaged ships detected. Restarting 3-2-A!`n")
			new_sub()
			flag_subneedsreplacing := 0 ; no sub needs to be replaced , can be found in repair.ahk function ship_girl_6_check() , retreat()/if statement in battle.ahk
			san_ni_a()
			} 
			
		if (flag_retreat = 1) {
			DebugLog("flag_retreat activated, ending runs.`n")
			break
			break
			}
		}
		
	flag_sannia_sortie := 0
	return
	}

Ichiichi: ; sortie 1-1 
	{
	ichi_ichi()
	return
	}

Ichigo:
	{
	ichi_go()
	return
	}

Nini:
	{
	ni_ni()
	return
	}
	
Nini_farm:
	{
	nini_farm()
	return
	}
	
Nisan_farm:
	{
	ni_san_farm()
	return
	}
	
Nisan_farm_worldboss:
	{
	ni_san_farm_worldboss()
	return
	}

Nisan:
	{
	ni_san()
	return
	}
	
Niichi:
	{
	ni_ichi()
	return
	}
	
Goyon:
	{
	Go_yon()
	return
	}
	
PP:
	{
	Pause
	return
	}
	
Eichi:
	{
	e_ichi()
	return 
	}
	
; Do equipment quests
DoEquipmentQuest:
	{
	DebugLog("Do equipment quests..`n")
	do_equipment_quest() 
	return
	}
	
ResetDifficulty:
	{
	ResetDifficulty()
	return
	}

Auto_send:
	{
	exp_claim()
	rand_sleep(1000,3000)
	resupply()
	
	GuiControlGet Fleet_2 ; grabs the associated number 
	if Fleet_2 = 1 
		{ ; fleet 2   
		DebugLog("Send fleet 2 on expedition received!`n")
		flag_sendfleet2 := 1 ; send fleet 2 flag 
		} 
	GuiControlGet Fleet_3 ; grabs the associated number 
	if Fleet_3 = 1 
		{ ; fleet 3 
		DebugLog("Send fleet 3 on expedition received!`n")
		flag_sendfleet3 := 1 ; send fleet 3 flag 
		} 
	GuiControlGet Fleet_4 ; grabs the associated number 
	if Fleet_4 = 1 
		{ ; fleet 4 
		DebugLog("Send fleet 4 on expedition received!`n")		
		flag_sendfleet4 := 1 ; send fleet 3 flag 
		} 
	if flag_sendexpedition = 0 
		{
		rand_sleep(2000,4000)
		flag_sendexpedition := 1 ; start send expedition flag
		send_expedition() ; this can be found in the expeditions.ahk
		rand_sleep(500,2000)
		}
	return
	}

Auto_send_noclaim:
	{
	rand_sleep(1000,3000)
	resupply()
	GuiControlGet Fleet_2 ; grabs the associated number 
	if Fleet_2 = 1 
		{ ; fleet 2   
		DebugLog("Send fleet 2 on expedition received!`n")
		flag_sendfleet2 := 1 ; send fleet 2 flag 
		} 
	GuiControlGet Fleet_3 ; grabs the associated number 
	if Fleet_3 = 1 
		{ ; fleet 3 
		DebugLog("Send fleet 3 on expedition received!`n")
		flag_sendfleet3 := 1 ; send fleet 3 flag 
		} 
	GuiControlGet Fleet_4 ; grabs the associated number 
	if Fleet_4 = 1 
		{ ; fleet 4 
		DebugLog("Send fleet 4 on expedition received!`n")		
		flag_sendfleet4 := 1 ; send fleet 3 flag 
		} 
	if flag_sendexpedition = 0 
		{
		rand_sleep(2000,4000)
		flag_sendexpedition := 1 ; start send expedition flag
		send_expedition() ; this can be found in the expeditions.ahk
		rand_sleep(500,2000)
		}
	return
	}
	
Res:
	{
	Reload ; restart the script
	return
	}
	
Timeleft: 
	{ ; display information regarding all timers
	display := ""
	For index, element in Timer
		{
		Time_Left := Round(Abs(Timer(index,"L") / 1000), 2)
		Minute_Left := Round(Abs(Timer(index,"L") / 60000), 2)
		if Timer(index)
		display .= index " : Timer is Done!  Finished " Time_Left " seconds ago | " Minute_Left " minutes ago`n" 
		else
		display .= index " : Timer has " Time_Left " seconds left  | " Minute_Left " minutes left`n"
		}
	MsgBox % display
	return
}

EditTimer2:
	{
	Name = Expedition_2
	InputBox, Duration_uc, Set Timer, Enter %Name% Timer Duration in Minutes
	Duration := Duration_uc*1000*60
	Timer(Name, Duration)
	return
	}

EditTimer3:
	{
	Name = Expedition_3
	InputBox, Duration_uc, Set Timer, Enter %Name% Timer Duration in Minutes
	Duration := Duration_uc*1000*60
	Timer(Name, Duration)
	return
	}
	
EditTimer4:
	{
	Name = Expedition_4
	InputBox, Duration_uc, Set Timer, Enter %Name% Timer Duration in Minutes
	Duration := Duration_uc*1000*60
	Timer(Name, Duration)
	return
	}
	
	
FlagCheck:
	{
	Msgbox %flag_expedition_2_back% %flag_auto2% %flag_expedition_3_back% %flag_auto3% %flag_expedition_4_back% %flag_auto4%
	return
	}
	
Startloop:
	{
	DebugLog("Bot Started!`n")
	flag_runloop := 1
	; the first check for expeditions 
	automation_first_check()
	
	while (flag_runloop = 1) {
	
		if (flag_runloop = 0) {
			DebugLog("Stopping bot.`n")
			break
			}
			
		if (expedition_complete_check() = 1) { ; if expeditions are back 
			DebugLog("An expedition is back. Preparing it for automation!`n")
			automation_autosend()
				} else {
					expedition_prepare_automation() ; prepare expeditions for automation 
					}
			
		Sleep 20000 ; sleep 
		
		if (flag_runloop = 0) {
			DebugLog("Stopping bot.`n")
			break
			}
			
		} 

	return
	}

Stoploop:
	{
	DebugLog("Stop bot message sent.`n")
	flag_runloop := 0
	return
	}
	


Return ; end

;
; Program  
; 


	

	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
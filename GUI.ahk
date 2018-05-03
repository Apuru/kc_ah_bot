; GUI for the panel 
; info:
; gSend_2, gSend3, gSend4 = start expedition buttons 
; vExpchoicefleet2, vExpchoicefleet3, vExpchoicefleet4 = related to expeditions

; vFleet_1, v_Fleet2, v_Fleet3, v_Fleet4 = related to resupply 
; gResupneeded = resupply button 

; gExpclaim = claim expedition 
; gHomecheck = home check test button 

;
; GUI = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = = 
; 

; always on top 
Gui +AlwaysOnTop 

; debug log 
Gui, Add, GroupBox, x22 y10 w390 h170 , Debug Log
Gui, Add, Edit, Readonly x32 y30 w370 h140 vDebug 

; create log file for debug log 
; newFileNamePath = active_log.txt ; disable logs

; send fleet
Gui, Add, GroupBox, x22 y180 w390 h300 , Start Expedition

Gui, Add, Button, x32 y200 w110 h30 gSend_2, Send Fleet 2
Gui, Add, Radio, x42 y240 w100 h30 v1Expchoicefleet2 , Expedition 2 (Ammo+Buckets)
Gui, Add, Radio, x42 y280 w100 h30 v2Expchoicefleet2 , Expedition 3 (Steel)
Gui, Add, Radio, x42 y320 w100 h30 v3Expchoicefleet2 , Expedition 5 (Fuel+Ammo)
Gui, Add, Radio, x42 y360 w100 h30 v4Expchoicefleet2 , Expedition 6 (Bauxite)
Gui, Add, Radio, x42 y400 w100 h30 v5Expchoicefleet2 checked, Custom  
Gui, Add, DropDownList, x42 y440 w100 h20 R5 vExpList2 Choose3, 04(Buckets)|10(Buckets)|21(Fuel)|37(Ammo+Steel)|38(Fuel+Steel) ; disabled until implementation 

Gui, Add, Button, x162 y200 w110 h30 gSend_3, Send Fleet 3
Gui, Add, Radio, x172 y240 w100 h30 v1Expchoicefleet3 , Expedition 2 (Ammo+Buckets)
Gui, Add, Radio, x172 y280 w100 h30 v2Expchoicefleet3 , Expedition 3 (Steel)
Gui, Add, Radio, x172 y320 w100 h30 v3Expchoicefleet3 , Expedition 5 (Fuel+Ammo)
Gui, Add, Radio, x172 y360 w100 h30 v4Expchoicefleet3 , Expedition 6 (Bauxite)
Gui, Add, Radio, x172 y400 w100 h30 v5Expchoicefleet3 Checked, Custom 
Gui, Add, DropDownList, x172 y440 w100 h21 R5 vExpList3 Choose5, 04(Buckets)|10(Buckets)|21(Fuel)|37(Ammo+Steel)|38(Fuel+Steel) ; disabled until implementation 

Gui, Add, Button, x292 y200 w110 h30 gSend_4, Send Fleet 4
Gui, Add, Radio, x302 y240 w100 h30 v1Expchoicefleet4 , Expedition 2 (Ammo+Buckets)
Gui, Add, Radio, x302 y280 w100 h30 v2Expchoicefleet4 , Expedition 3 (Steel)
Gui, Add, Radio, x302 y320 w100 h30 v3Expchoicefleet4 , Expedition 5 (Fuel+Ammo)
Gui, Add, Radio, x302 y360 w100 h30 v4Expchoicefleet4 Checked, Expedition 6 (Bauxite)
Gui, Add, Radio, x302 y400 w100 h30 v5Expchoicefleet4 , Custom 
Gui, Add, DropDownList, x302 y440 w100 h21 R5 vExpList4 Choose3, 04(Buckets)|10(Buckets)|21(Fuel)|37(Ammo+Steel)|38(Fuel+Steel)|39 ; disabled until implementation 

; resupply 
Gui, Add, GroupBox, x422 y10 w190 h140 , Resupply
Gui, Add, CheckBox, x452 y30 w50 h30 vFleet_1 1, Fleet 1
Gui, Add, CheckBox, x532 y30 w50 h30 vFleet_2 1, Fleet 2
Gui, Add, CheckBox, x452 y60 w50 h30 vFleet_3 1, Fleet 3
Gui, Add, CheckBox, x532 y60 w50 h30 vFleet_4 1, Fleet 4
Gui, Add, Button, x462 y100 w100 h30 gResupneeded, Resupply ; button 

; misc box
Gui, Add, GroupBox, x422 y150 w190 h180 , Misc
Gui, Add, Button, x432 y170 w80 h30 gExpclaim, Claim ; button to refresh expeditions 
Gui, Add, Button, x522 y170 w80 h30 gRes, Reload
Gui, Add, Button, x432 y210 w80 h30 gAuto_send_noclaim, ResSend
Gui, Add, Button, x522 y210 w80 h30 gFlagCheck, Flag Check
Gui, Add, Button, x432 y250 w80 h30 gAuto_send, ClaimResSend
Gui, Add, Button, x522 y250 w80 h30 gRetreat, Retreat 
Gui, Add, Button, x432 y290 w80 h30 Disabled, null6
Gui, Add, Button, x522 y290 w80 h30 gRepair, Repair

; 3-2-A box
Gui, Add, GroupBox, x422 y330 w190 h150 , 3-2-A
Gui, Add, Button, x432 y350 w80 h30 , 3-2-A Normal
Gui, Add, Button, x522 y350 w80 h30 , 3-2-A Super
Gui, Add, CheckBox, x432 y390 w80 h30 vSelectNewSub, Replace Sub

; right extension
Gui, Add, GroupBox, x622 y10 w190 h100 , Control
Gui, Add, Button, x632 y30 w80 h30 gStartloop, Start Bot
Gui, Add, Button, x722 y30 w80 h30 gStoploop, Stop Bot
Gui, Add, Button, x632 y70 w80 h30 gPP, Pause
Gui, Add, CheckBox, x722 y70 w80 h30 vMoveMouse checked 1, Move Mouse

; Sorties
Gui, Add, GroupBox, x622 y110 w190 h220 , Sorties
Gui, Add, Button, x632 y130 w80 h30 gIchiichi, 1-1 Sortie
Gui, Add, Button, x722 y130 w80 h30 gIchigo, 1-5 Sortie
Gui, Add, Button, x632 y170 w80 h30 gNiichi, 2-1 Sortie
Gui, Add, Button, x722 y170 w80 h30 gNini, 2-2 Sortie
Gui, Add, Button, x632 y210 w80 h30 gNisan, 2-3 Sortie
Gui, Add, Button, x722 y210 w80 h30 gSannia, 3-2-A Sortie
Gui, Add, Button, x632 y250 w80 h30 gNisan_farm, 2-3 (no night)
Gui, Add, Button, x722 y250 w80 h30 gNini_farm, 2-2 (no night)
Gui, Add, Button, x632 y290 w80 h30 gNisan_farm_worldboss, 2-3 (world boss)
Gui, Add, Button, x722 y290 w80 h30 gGoyon, 5-4 (Sub)

; bottom right box
Gui, Add, GroupBox, x622 y330 w190 h140 , Automation Related
Gui, Add, Button, x632 y350 w80 h30 gEditTimer2, Fleet2 Timer
; Gui, Add, Button, x722 y390 w80 h30 Disabled, null1
; Gui, Add, Button, x722 y390 w80 h30 gEichi, E1
Gui, Add, Button, x722 y390 w80 h30 gDoEquipmentQuest, EqQuest
Gui, Add, Button, x632 y390 w80 h30 gEditTimer3, Fleet3 Timer
Gui, Add, Button, x722 y350 w80 h30 gTimeleft, Time Left
Gui, Add, Button, x632 y430 w80 h30 gEditTimer4, Fleet4 Timer
Gui, Add, Button, x722 y430 w80 h30 gResetDifficulty, E1 Reset

; show gui
Gui, Show, x373 y179 X-870 Y446 h492 w829, Kantai Collection - Macro Panel by Applejack v3 ; name of window, capital X Y represents where the window will show up relative to screen when opened

; message to mark when it started 
DebugLog("Started!`n")
Return 


GuiClose: 
Gui, Destroy
; GUI copy log to file 
FormatTime, DateString, A_Now, yyyy-MM-dd_HH.mm ; Get date in desired format
	; disable logs
	/*
newFileNamePath = Log_%DateString%.txt ; Create a new file name an location 
FileCopy, active_log.txt, %newFileNamePath% 
FileDelete, active_log.txt ; delete the active log
	*/
ExitApp 

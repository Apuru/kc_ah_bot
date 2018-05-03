; General functions for the macro panel 
;
; By Applejack 2015-05-15

global flag_resupply_checker := 0 ; for resupply checker counts
global flag_resupply_checked_count := 0 ; actually counter for how many times checked

; purpose of this is allow the macros to post text into the text box for debugging purposes 
; a debugger console 
DebugLog(Data) { ; used function for sending text
	FormatTime, TimeString, A_Now, [hh:mm:ss tt] ; Generates a time stamp for the top of the log.
	GuiControlGet, Debug
	GuiControl,, Debug, %TimeString% - %Data%%Debug%`n ; new data gets sent to the top, moving old data down one line
	FileAppend, %TimeString% - %Data%, active_log.txt
} 

; rand 

Rand_Sleep(time_low, time_high) { 
	Random, rand, %time_low%, %time_high% ; Generate sleep time between time_low and time_high in ms
	Sleep %rand% ; Sleep the generated time
	} ; credits to the dude who uploaded his Kantai Collection Bot on pastebin back in 2014!! 
	
Rand_ControlClick(x1,y1,x2,y2) {
	Random, x3, %x1%, %x2% 
	Random, y3, %y1%, %y2% 
	ControlClick, x%x3% y%y3%,KanColleViewer!,, LEFT, 1, NA Pos 
	return
	} 
	
Rand_MouseMoveAndClick(x1,y1,x2,y2) { ; obviously for resupplying all ; depreciated because it doesnt work 
	Coordmode Mouse 
	Coordmode Pixel 
	Random, x3, %x1%, %x2% 
	Random, y3, %y1%, %y2% 
	; Msgbox X = %x3%`nY = %y3% ; for debugging purposes 
	MouseMove, %x3%, %y3% 
	ControlClick, x%x3% y%y3%,KanColleViewer!,, LEFT, 1, NA Pos
	ControlClick, x%x3% y%y3%,KanColleViewer!,, LEFT, 1, NA Pos
	return 
	}

millisecond_delay() {
	loop 50 {
		randVar := 1+1
		}
	}
	
Rand_ControlDoubleClick(x1,y1,x2,y2) { ; its not really double but necessary for the stupid resupply bullshit
	Random, x3, %x1%, %x2% 
	Random, y3, %y1%, %y2% 
	ControlClick, x%x3% y%y3%,KanColleViewer!,, LEFT, 1, NA Pos ; 
	ControlClick, x%x3% y%y3%,KanColleViewer!,, LEFT, 1, NA Pos ; 
	Sleep 1 
	ControlClick, x%x3% y%y3%,KanColleViewer!,, LEFT, 1, NA Pos ; 
	ControlClick, x%x3% y%y3%,KanColleViewer!,, LEFT, 1, NA Pos ; 
	return
	} 
	
Rand_NormalClick(x1,y1,x2,y2) {
	Random, x3, %x1%, %x2% 
	Random, y3, %y1%, %y2% 
	Click %x3%, %y3%
	return
	}
	


;
; Checkers 
;

nightbattle_check() { ; checks for night battle screen
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, nightbattle_yesX, nightbattle_yesY, -1680, 0, 3600, 1080, images/nightbattle_yes.bmp ; searches for nightbattle kanji (right button)
		if (ErrorLevel = 0) {
		nightbattlescreen_ok := 1 ; 
		} 
		
	ImageSearch, nightbattle_noX, nightbattle_noY, -1680, 0, 3600, 1080, images/nightbattle_no.bmp ; searches for stop pursuit kanji (left button)
		if (ErrorLevel = 0) {
		nightbattlescreen_ok := 1 ; 
		} 	

		if (nightbattlescreen_ok = 1) {
		return 1 ; success
		} else {
		return 0 
		}
	}

pursuit_check() { ; check for pursuit screen 
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, pursuit_noX, pursuit_noY, -1680, 0, 3600, 1080, images/pursuit_no.bmp ; searches right button kanji
		if (ErrorLevel = 0) {
		pursuitscreen_ok := 1 
		} 
		
	ImageSearch, pursuit_yesX, pursuit_yesY, -1680, 0, 3600, 1080, images/pursuit_yes.bmp ; searches left button kanji
		if (ErrorLevel = 0) {
		pursuitscreen_ok := 1 
		} 	

		if (pursuitscreen_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
victory_check() { ; check for victory screen  
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, victoryX, victoryY, -1680, 0, 3600, 1080, images/victory.bmp ; searches for kanji on top left 
		if (ErrorLevel = 0) {
		victoryscreen_ok := 1 
		} 
		
	ImageSearch, victory2X, victory2Y, -1680, 0, 3600, 1080, images/victory2.bmp ; searches for spinning button (bottom right)
		if (ErrorLevel = 0) {
		victoryscreen_ok := 1 
		} 	

		if (victoryscreen_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
formation_check() { ; Checks if the current screen is the home screen with expedition complete  
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, formation_1X, formation_1Y, -1680, 0, 3600, 1080, images/formation_1.bmp ; searches for kanji on top left 
		if (ErrorLevel = 0) {
		formation_ok := 1 
		} 
		
	ImageSearch, formation_2X, formation_2Y, -1680, 0, 3600, 1080, images/formation_1.bmp ; searches for spinning button (bottom right)
		if (ErrorLevel = 0) {
		formation_ok := 1 
		} 	

		if (formation_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
compass_check() { ; Checks if the current screen is the home screen with expedition complete  
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, compass1X, compass1Y, -1680, 0, 3600, 1080, images/compass_1.bmp ; searches for kanji on top left 
		if (ErrorLevel = 0) {
		compass_ok := 1 
		} 
		
	ImageSearch, compass2X, compass2Y, -1680, 0, 3600, 1080, images/compass_2.bmp ; searches for spinning button (bottom right)
		if (ErrorLevel = 0) {
		compass_ok := 1 
		} 	

		if (compass_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}

clearscreen_check() { ; checks for clear screen 
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, clearscreen_yesX, clearscreen_yesY, -1680, 0, 3600, 1080, images/clearscreen_1.bmp ; searches for clearscreen kanji (right button)
		if (ErrorLevel = 0) {
		clearscreen_ok1 := 1 ; 
		} 
		
	ImageSearch, clearscreen_noX, clearscreen_noY, -1680, 0, 3600, 1080, images/clearscreen_2.bmp ; searches for stop pursuit kanji (left button)
		if (ErrorLevel = 0) {
		clearscreen_ok2 := 1 ; 
		} 	
	
	ImageSearch, clearscreen_noX, clearscreen_noY, -1680, 0, 3600, 1080, images/clearscreen_3.bmp ; searches for stop pursuit kanji (left button)
		if (ErrorLevel = 0) {
		clearscreen_ok3 := 1 ; 
		} 	
	
	clearscreen_final := clearscreen_ok1 + clearscreen_ok2 + clearscreen_ok3 
	
		if (clearscreen_final >= 2) {
		return 1 ; success
		} else {
		return 0 
		}
	}
	
disconnect_check() { ; needs updating 
	PixelSearch cat_x, cat_y, -1680, 0, 3600, 1080, 0x877BB0, 2, fast 
    if (ErrorLevel = 0) { ; check if cat is present
        cat_ok := 1
    }
    PixelSearch ribbon_x, ribbon_y, -1680, 0, 3600, 1080, 0xFFFC9F, 2, fast
    if (ErrorLevel = 0) { ; check if the ribbon is present (ribbon on the right)
        ribbon_ok := 1
    }
    PixelSearch sweatdrop_x, sweatdrop_y, -1680, 0, 3600, 1080, 0xFFF2B0, 5, fast
    if (ErrorLevel = 0) { ; check if the sweat drop is present
        sweatdrop_ok := 1
    }
    PixelSearch textcheck_x, textcheck_y, -1680, 0, 3600, 1080, 0x00BC9F, 5, fast
    if (ErrorLevel = 0) { ; check if last character su is present
        textcheck_ok := 1
    }
        condition_check := cat_ok + ribbon_ok + sweatdrop_ok + textcheck_ok
        if (condition_check = 4) { ; check if all are present
		return 1 
		} else {
		return 0
		}
	}
	
home_screen_check() { ; is this the homescreen? // searches for the shutsugeki icon
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, shutsugekiX, shutsugekiY, -1680, 0, 3600, 1080, images/shutsugeki.bmp ; searches entire screen for the sortie button, wooooooo
		if (ErrorLevel = 0) {
		homescreen_ok := 1 ; This is home screen.
		} 
		
	ImageSearch, shutsugekiX, shutsugekiY, -1680, 0, 3600, 1080, images/shutsugeki2.bmp ; addtional image just in case
		if (ErrorLevel = 0) {
		homescreen_ok := 1 ; This is home screen.
		} 	
		
		if (homescreen_ok = 1) {
		return 1
		} else {
		return 0
		}
	}
	
reconnect() { ; reconnect if we've disconnected
	IfWinExist, KanColleViewer! 
	{
		WinActivate 
		Sleep 3000
	} 
	Click, 1432, 119, 1 ; click settings tab
	Sleep 1000
	Click, 1658, 160, 1 ; click reload
	Sleep 15000 
	Click, 948, 117, 1 ; it doesn't matter but lets go back to the fleet screen
	Sleep 2000
	Rand_NormalClick(476,426,756,474) ;; the start button cannot be control clicked
	Sleep 30000 ; wait a bit 
	} 
	
resupply() {
	mresupneeded := 1 ; 
	DebugLog("Resupply activated.`n")
	
	if (sidebar_check() = 1) { ; quicker to use the side bar
		Rand_ControlClick(14,237,39,270) ;; click side resupply button 
		Rand_Sleep(2500,5000)
		} else if (home_screen_check() = 0) { ; if we're not on the homescreen, lets try and go there.
			DebugLog("We're not home, attempting to return!`n")
			Rand_ControlClick(11,55,90,125) ;; click home button 
			Rand_Sleep(2500,5000)
			} else if (home_screen_check() = 1) {
				DebugLog("Clicking resupply button.`n")
				Rand_ControlClick(62,244,106,292) ;; home resupply 
				Rand_Sleep(2500,5000)
				}
		
	; click resupply button 
	
	GuiControlGet Fleet_1 ; grabs the associated number 
	if Fleet_1 = 1 
		{ ; starts on fleet 1 since that is the default fleet shown when its opened {
		DebugLog("Resupplying fleet 1.`n")
		Rand_Sleep(2500,5000)
		selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
		} 
	GuiControlGet Fleet_2 ; grabs the associated number 
	if Fleet_2 = 1 
		{ ; fleet 2   
		DebugLog("Resupplying fleet 2.`n")
		Rand_ControlClick(178,161,188,172) ;; click fleet 2
		Rand_Sleep(100,500)
		Rand_ControlClick(178,161,188,172) ;; click fleet 2
		Rand_Sleep(100,500)
		Rand_ControlClick(178,161,188,172) ;; click fleet 2
		Rand_Sleep(2500,5000)
		selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
		} 
	GuiControlGet Fleet_3 ; grabs the associated number 
	if Fleet_3 = 1 
		{ ; fleet 3 
		DebugLog("Resupplying fleet 3.`n")
		Rand_ControlClick(209,160,219,172) ;; click fleet 3
		Rand_Sleep(2500,5000)
		selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
		} 
	GuiControlGet Fleet_4 ; grabs the associated number 
	if Fleet_4 = 1 
		{ ; fleet 4 
		DebugLog("Resupplying fleet 4.`n")
		Rand_ControlClick(237,159,249,172) ;; click fleet 4
		Rand_Sleep(2500,5000)
		selectall_resup() ; select all ships and resupply, this function can be found in expedition_send.ahk
		} 
		
	Rand_ControlClick(11,55,90,125) ;; click home button 
	mresupneeded := 0 ; 
	DebugLog("Done resupplying!.`n")
	Rand_Sleep(5000,10000)
	}
	
resupply_checker() { ; make sure ship girls are supplied
	Coordmode Pixel ; sets coordmode entire screen for full background potential
	flag_resupply_checker := 0 ; set check count to 0, need 5 to succeed
	flag_resupply_checked_count := 0 ; set check count to 0, need 30 to break
	Rand_Sleep(3400,5800)
	loop {
		resupply_ok := 0
		Sleep 10
		ImageSearch, sidebarX, sidebarY, -1191, 181, -1156, 504, images/resupply_bar.bmp 
			if (ErrorLevel = 0) {
			resupply_ok += 1
			}
		ImageSearch, sidebarX, sidebarY, -1118, 181, -1087, 504, images/resupply_bar.bmp 
			if (ErrorLevel = 0) {
			resupply_ok += 1
			}
		if (resupply_ok <= 1) { ; if both not successful, resupply
			flag_resupply_checked_count += 1 ; check how many times checked
			; DebugLog("Found that ship girls weren't resupplied. Resupplying!`n")
			Rand_ControlDoubleClick(119,160,132,174) ;; select all ships and resupply
			} else if (resupply_ok = 2) { ; if both successful, lets continue
				flag_resupply_checker += 1 ; check how many times successful
				flag_resupply_checked_count += 1 ; check how many times checked
				}
		if (flag_resupply_checker >= 3) {
			DebugLog("Resupply successful.`n")
			Rand_Sleep(1000,3000)
			break
			} else if (flag_resupply_checked_count >= 50) {
				DebugLog("Reached threshold for check, stopping.`n")
				break
				}
			} ; end loop
	}
	
sidebar_check() { ; checks for sidebar
	sidebarscreen_ok := 0 
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, sidebarX, sidebarY, -1680, 0, 3600, 1080, images/sidebar_1.bmp ; organize side button
		if (ErrorLevel = 0) {
		sidebarscreen_ok += 1 
		} 
		
	ImageSearch, sidebar2X, sidebar2Y, -1680, 0, 3600, 1080, images/sidebar_2.bmp ; modernize side button
		if (ErrorLevel = 0) {
		sidebarscreen_ok += 1 
		} 	
		
	ImageSearch, sidebar2X, sidebar2Y, -1680, 0, 3600, 1080, images/sidebar_3.bmp ; factory side button
		if (ErrorLevel = 0) {
		sidebarscreen_ok += 1 
		} 	

		if (sidebarscreen_ok >= 2) { ; only two success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
ResetDifficulty() { ; reset the difficulty of E1 for farming, need to change the Event click to change the reset 
; starts on the event screen 
	Rand_Sleep(1000,2000)
	Rand_ControlClick(422,203,725,261) ; click event 1 
	; dont need the extra click for E4 reset
	; Rand_Sleep(1000,2000)
	; Rand_ControlClick(256,157,713,410) ; click green board
	Rand_Sleep(1000,2000)
	Rand_ControlClick(479,97,587,117) ; click difficulty button 
	Rand_Sleep(1000,2000)
	Rand_ControlClick(309,264,368,318) ; click medium difficulty 
	Rand_Sleep(1500,3000)
	Rand_ControlClick(450,333,537,352) ; click yes
	Rand_Sleep(2500,4000)
	Rand_ControlClick(354,194,571,270) ; click to go back
	Rand_Sleep(1500,3000)
	Rand_ControlClick(422,203,725,261) ; click event 1 
	; Rand_Sleep(1000,2000)
	; Rand_ControlClick(256,157,713,410) ; click green board
	Rand_Sleep(2000,3000)
	Rand_ControlClick(479,97,587,117) ; click difficulty button 
	Rand_Sleep(1000,2000)
	Rand_ControlClick(460,266,507,320) ; click easy difficulty 
	Rand_Sleep(1500,3000)
	Rand_ControlClick(450,333,537,352) ; click yes
	Rand_Sleep(2500,4000)
	Rand_ControlClick(354,194,571,270) ; click to go back
	
	}

; removed as of new UI patch 2015-10-09
/* 
resupply_box_check() { 
	CoordMode Pixel ; sets coordmode entire screen for full background potential
	ImageSearch, resupply_boxX, resupply_boxY, -1680, 0, 3600, 1080, images/resupply_box.bmp *30
		if (ErrorLevel = 0) {
		resupply_box_screen_ok := 1 
		} 
		
		if (resupply_box_screen_ok = 1) { 
		return 1 ; found empty box
		} else {
		return 0 
		}
	}
*/ 


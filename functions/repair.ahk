; these values tell which repair slot is open to receive repair 
global flag_repair_slot1_free 
global flag_repair_slot2_free 
global flag_repair_slot3_free 
global flag_repair_slot4_free 

; these values check the repair page for which ships need to be repaired 
global flag_slot1_needs_repair
global flag_slot2_needs_repair
global flag_slot3_needs_repair
global flag_slot4_needs_repair
global flag_slot5_needs_repair
global flag_slot6_needs_repair

; eh
global repair_count

; flag to repeat the repair
global flag_repaired

; flags for selecting a new sub
global flag_kanmusu_set
global flag_ten_counter
global sub_number

; global for stopping 3-2-A
global flag_retreat

; global for switching out the sub
global flag_subneedsreplacing

; global for when we use a bucket 
global flag_usingbucket

repair_slot1_check() { 
	CoordMode Pixel 
	ImageSearch, repairX, repairY, -1543, 161, -1300, 238, images/repair_1.bmp 
		if (ErrorLevel = 0) {
		repair_slot1_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1543, 161, -1300, 238, images/repair_2.bmp 
		if (ErrorLevel = 0) {
		repair_slot1_ok := 1 
		} 
		if (repair_slot1_ok = 1) { ; only one success is required
		return 1 ; succes
		} else {
		return 0 
		}
	}
	
repair_slot2_check() { 
	CoordMode Pixel 
	ImageSearch, repairX, repairY, -1543, 238, -1300, 321, images/repair_1.bmp 
		if (ErrorLevel = 0) {
		repair_slot2_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1543, 238, -1300, 321, images/repair_2.bmp 
		if (ErrorLevel = 0) {
		repair_slot2_ok := 1 
		} 
		if (repair_slot2_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
repair_slot3_check() { 
	CoordMode Pixel 
	ImageSearch, repairX, repairY, -1543, 321, -1300, 410, images/repair_1.bmp 
		if (ErrorLevel = 0) {
		repair_slot3_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1543, 321, -1300, 410, images/repair_2.bmp 
		if (ErrorLevel = 0) {
		repair_slot3_ok := 1 
		} 
		if (repair_slot3_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
repair_slot4_check() { 
	CoordMode Pixel 
	ImageSearch, repairX, repairY, -1543, 410, -1327, 492, images/repair_1.bmp 
		if (ErrorLevel = 0) {
		repair_slot4_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1543, 410, -1327, 492, images/repair_2.bmp 
		if (ErrorLevel = 0) {
		repair_slot4_ok := 1 
		} 
		if (repair_slot4_ok = 1) { ; only one success is required
		return 1 ; success
		} else {
		return 0 
		}
	}
	
repair_screen_open_check() { ; if repair screen is not open, then we will open it
	Rand_Sleep(1000,2000)
	ImageSearch, repairX, repairY, -1535, 469, -1028, 519, images/repair_screen_check.bmp 
		if (ErrorLevel = 1 OR Errorlevel = 2) { ; if its not there, lets open the repair screen
			if (repair_check() = 1) { ; check if any repair slots are open
					DebugLog("Checking slots`n")
					if (flag_repair_slot1_free = 1) {
					Rand_ControlClick(187,197,335,226) ;; slot 1
					Sleep 500
					} else if (flag_repair_slot2_free = 1) {
						Rand_ControlClick(184,277,335,309) ;; slot 2
						Sleep 500
						} else if (flag_repair_slot3_free = 1) {
							Rand_ControlClick(185,359,335,391) ;; slot 3
							Sleep 500
							} else if (flag_repair_slot4_free = 1) {
								Rand_ControlClick(186,439,336,469) ;; slot 4
								Sleep 500
								} 	
					} else {
						return ; if there are no slots then there is nothing to do, let us end. 
						}
		} 
	}
	
repair_screen_close_check() { ; if repair screen is open, we close it 
	DebugLog("Closing repair tab before doing the full check.`n")
	Rand_Sleep(2000,5000)
	Sleep 500
	DebugLog("Closing repair screen?.`n")
	Rand_ControlClick(101,167,166,474) ;; click some random place to close repair screen
	Rand_Sleep(2000,5000)
	} 
	
repair_check() { ; checks if any slots are free 
	if (repair_slot1_check() = 1) {
		flag_repair_slot1_free := 1
		} else {
		flag_repair_slot1_free := 0
		}
	if (repair_slot2_check() = 1) {
		flag_repair_slot2_free := 1
		} else {
		flag_repair_slot2_free := 0
		}
	if (repair_slot3_check() = 1) {
		flag_repair_slot3_free := 1
		} else {
		flag_repair_slot3_free := 0
		}
	if (repair_slot4_check() = 1) {
		flag_repair_slot4_free := 1
		} else {
		flag_repair_slot4_free := 0
		}
	if (flag_repair_slot1_free = 1 OR flag_repair_slot2_free = 1 OR flag_repair_slot3_free = 1 OR flag_repair_slot4_free = 1) {
		return 1 ; repair slots available
		} else {
		return 0 ; no repair slots available
		}
	}
	
repair_yes() {
	rand_sleep(1000,2000)
	Rand_ControlClick(625,467,757,502) ;; click yes 1 repair 
	rand_sleep(1000,2000)
	Rand_ControlClick(462,438,557,457) ;; click hai
	flag_repaired := 1
	if (flag_usingbucket = 1) { ; if we've used a bucket 
		Rand_Sleep (2000,5000) ; just a little extra wait time 
		}
	rand_sleep(6000,8000)
	}
	
repair_top6_list_check() { ; scan top 6 most-damaged ships on the list
	Coordmode Pixel ; Interprets the coordinates below as relative to the screen rather than the active window.
	
	; slot 1 check
	ImageSearch, repairX, repairY, -1680, 164, 3600, 194, images/repairshiplist_1.bmp ; check for the full health repair bar
		if (ErrorLevel = 0) {
		repair_top1_list := 1 
		} 
	ImageSearch, repairX, repairY, -1680, 164, 3600, 194, images/repairshiplist_2.bmp ; check if its already being repaired
		if (ErrorLevel = 0) {
		repair_top1_list := 1 
		} 
	
		if (repair_top1_list = 1) { ; if above conditions apply, make it 0 otherwise make it 1
			flag_slot1_needs_repair := 0
			} else {
			flag_slot1_needs_repair := 1
			}
	Sleep 100
	
	; slot 2 check
	ImageSearch, repairX, repairY, -1680, 194, 3600, 226, images/repairshiplist_1.bmp ; check for the full health repair bar
		if (ErrorLevel = 0) {
		repair_top2_list := 1 
		} 
	ImageSearch, repairX, repairY, -1680, 194, 3600, 226, images/repairshiplist_2.bmp ; check if its already being repaired
		if (ErrorLevel = 0) {
		repair_top2_list := 1 
		} 
		
		if (repair_top2_list = 1) { ; if above conditions apply, make it 0 otherwise make it 1
			flag_slot2_needs_repair := 0
			} else {
			flag_slot2_needs_repair := 1
			}
	Sleep 100		
		
	; slot 3 check
	ImageSearch, repairX, repairY, -1680, 226, 3600, 257, images/repairshiplist_1.bmp ; check for the full health repair bar
		if (ErrorLevel = 0) {
		repair_top3_list := 1 
		} 
	ImageSearch, repairX, repairY, -1680, 226, 3600, 257, images/repairshiplist_2.bmp ; check if its already being repaired
		if (ErrorLevel = 0) {
		repair_top3_list := 1 
		} 

		if (repair_top3_list = 1) { ; if above conditions apply, make it 0 otherwise make it 1
			flag_slot3_needs_repair := 0
			} else {
			flag_slot3_needs_repair := 1
			}
	Sleep 100		
			
	; slot 4 check
	ImageSearch, repairX, repairY, -1680, 257, 3600, 288, images/repairshiplist_1.bmp ; check for the full health repair bar
		if (ErrorLevel = 0) {
		repair_top4_list := 1 
		} 
	ImageSearch, repairX, repairY, -1680, 257, 3600, 288, images/repairshiplist_2.bmp ; check if its already being repaired
		if (ErrorLevel = 0) {
		repair_top4_list := 1 
		} 

		if (repair_top4_list = 1) { ; if above conditions apply, make it 0 otherwise make it 1
			flag_slot4_needs_repair := 0
			} else {
			flag_slot4_needs_repair := 1
			}
	Sleep 100
	
	; slot 5 check
	ImageSearch, repairX, repairY, -1680, 288, 3600, 319, images/repairshiplist_1.bmp ; check for the full health repair bar
		if (ErrorLevel = 0) {
		repair_top5_list := 1 
		} 
	ImageSearch, repairX, repairY, -1680, 288, 3600, 319, images/repairshiplist_2.bmp ; check if its already being repaired
		if (ErrorLevel = 0) {
		repair_top5_list := 1 
		} 

		if (repair_top5_list = 1) { ; if above conditions apply, make it 0 otherwise make it 1
			flag_slot5_needs_repair := 0
			} else {
			flag_slot5_needs_repair := 1
			}
	Sleep 100
	
	; slot 6 check
	ImageSearch, repairX, repairY, -1680, 319, 3600, 349, images/repairshiplist_1.bmp ; check for the full health repair bar
		if (ErrorLevel = 0) {
		repair_top6_list := 1 
		} 
	ImageSearch, repairX, repairY, -1680, 319, 3600, 349, images/repairshiplist_2.bmp ; check if its already being repaired
		if (ErrorLevel = 0) {
		repair_top6_list := 1 
		} 

		if (repair_top6_list = 1) { ; if above conditions apply, make it 0 otherwise make it 1
			flag_slot6_needs_repair := 0
			} else {
			flag_slot6_needs_repair := 1
			}
	Sleep 100
	
	}

ship_girl_1_check() {
	Coordmode Pixel 
	; search for the red pixel on the first half ship girl 1's health bar
	PixelSearch red_x, red_y, -736, 105, -522, 135, 0x2020FF, 2, fast ; the 3rd coordinate (bottom right X) was previously -712 but something changed so i fixed it // -522 was previously -497
	if (Errorlevel = 0) {
		return 1 ; return value 1 if we've found the red pixel and she needs repairs
		}
	}
	
ship_girl_2_check() {
	Coordmode Pixel 
	; search for the red pixel on the first half ship girl 2's health bar
	PixelSearch red_x, red_y, -736, 135, -522, 175, 0x2020FF, 2, fast ; the 3rd coordinate (bottom right X) was previously -712 but something changed so i fixed it
	if (Errorlevel = 0) {
		return 1 ; return value 1 if we've found the red pixel and she needs repairs
		}
	}
	
ship_girl_3_check() {
	Coordmode Pixel 
	; search for the red pixel on the first half ship girl 3's health bar
	PixelSearch red_x, red_y, -736, 175, -522, 213, 0x2020FF, 2, fast ; the 3rd coordinate (bottom right X) was previously -712 but something changed so i fixed it
	if (Errorlevel = 0) {
		return 1 ; return value 1 if we've found the red pixel and she needs repairs
		}
	}
	
ship_girl_4_check() {
	Coordmode Pixel 
	; search for the red pixel on the first half ship girl 4's health bar
	PixelSearch red_x, red_y, -736, 213, -522, 252, 0x2020FF, 2, fast ; the 3rd coordinate (bottom right X) was previously -712 but something changed so i fixed it
	if (Errorlevel = 0) {
		return 1 ; return value 1 if we've found the red pixel and she needs repairs
		}
	}
	
ship_girl_5_check() {
	Coordmode Pixel ; interprets the coordinates below as relative to the screen rather than the active window.
	; search for the red pixel on the first half ship girl 5's health bar
	PixelSearch red_x, red_y, -736, 252, -522, 291, 0x2020FF, 2, fast ; the 3rd coordinate (bottom right X) was previously -712 but something changed so i fixed it
	if (Errorlevel = 0) {
		return 1 ; return value 1 if we've found the red pixel and she needs repairs
		}
	}
	
ship_girl_6_check() {
	Coordmode Pixel ; interprets the coordinates below as relative to the screen rather than the active window.
	; search for the red pixel on the first half ship girl 6's health bar 
	PixelSearch red_x, red_y, -736, 291, -522, 330, 0x2020FF, 2, fast ; the 3rd coordinate (bottom right X) was previously -712 but something changed so i fixed it
	if (Errorlevel = 0) {
		flag_subneedsreplacing := 1 ; if we've found that the sub needs to be repaired then we will need to switch it out
		return 1 ; return value 1 if we've found the red pixel and she needs repairs
		}
	}

1to5_ships_check() {
	if (ship_girl_1_check() = 1 OR ship_girl_2_check() = 1 OR ship_girl_3_check() = 1 OR ship_girl_4_check() = 1 OR ship_girl_5_check() = 1) {
		return 1
		}	
	}
	
repair_count() {
	repair_counter := 0
	if (ship_girl_1_check() = 1) {
		repair_counter += 1
		}
	if (ship_girl_2_check() = 1) {
		repair_counter += 1
		}
	if (ship_girl_3_check() = 1) {
		repair_counter += 1
		}
	if (ship_girl_4_check() = 1) {
		repair_counter += 1
		}
	if (ship_girl_5_check() = 1) {
		repair_counter += 1
		}
	if (ship_girl_6_check() = 1) {
		repair_counter += 1
		}
	return repair_counter
	}
	
all_ship_girls_check() {
	if (ship_girl_1_check() = 1 OR ship_girl_2_check() = 1 OR ship_girl_3_check() = 1 OR ship_girl_4_check() = 1 OR ship_girl_5_check() = 1 OR ship_girl_6_check() = 1) {
		return 1
		}	
	}
	
kcv_repair_check() {
	Coordmode Pixel ; interprets the coordinates below as relative to the screen rather than the active window.
	; first lets check if KCV is on the first0 fleet 
	ImageSearch, repairX, repairY, -1680, 0, 3600, 1080, images/kcv_repair_check_1.bmp 
		if (ErrorLevel = 1 OR Errorlevel = 2) {
		Soundbeep
		MsgBox Please click overview button (left most button on KCV)`nand click the first fleet then click ok. 
		} 
	} 

hour_time_check() { ; check if timer is under 1 hour 
	Coordmode Pixel 
	DebugLog("Doing hour time check function.`n")
	Rand_Sleep(1200,2400) ; wait a bit for the load screen
	ImageSearch, repairX, repairY, -980, 282, -933, 302, images/repair_timer.bmp 
		if (ErrorLevel = 0) {
		time_zero := 1
		}
	ImageSearch, repairX, repairY, -980, 282, -933, 302, images/repair_timer2.bmp 
		if (ErrorLevel = 0) {
		time_zero := 1
		}	
	if (time_zero = 1) {
		DebugLog("Repair is UNDER an hour. No bucket.`n")
		} else if (sub_check() = 0) { ; lets make sure its not a sub 
		; grab value from use buckets checkbox before clicking the instant repair 
		DebugLog("Repair is OVER an hour. Using bucket.`n")
		Rand_ControlClick(707,330,778,346) ;; click instant repair because its not under an hour 
		flag_usingbucket := 1
		Rand_Sleep(500,2000)
		} else {
		DebugLog("Else: Repair is UNDER an hour. No bucket.`n")
		}
	}
	
	
sub_check() { 
	DebugLog("Checking if its a sub.`n")
	Rand_Sleep(500,1500) ; sleep a bit for screen to come up
	CoordMode Pixel 
	ImageSearch, repairX, repairY, -1073, 187, -907, 235, images/sub_1.bmp ; i-168
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1073, 187, -907, 235, images/sub_2.bmp ; i-19 
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1073, 187, -907, 235, images/sub_3.bmp ; i-8
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1073, 187, -907, 235, images/sub_4.bmp ; i-56
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
	if (sub_ok = 1) { ; only one success is required
		return 1 ; success , this is a sub 
		} else {
		return 0 
		}
	}
	
end_san_ni_a_check() { ; our function to check if we need to end 
	repair_screen_close_check()
	Rand_Sleep(1500,3000)
	if (repair_check() = 0) { ; if there are no longer any repair slots left. lets end. 
		DebugLog("No more repair slots. Ending 3-2-A runs.`n")
		flag_retreat := 1 ; don't reloop 3-2-A
		} else if (new_sub() = 0) { ; do we want to replace this sub?
			DebugLog("No not replacing this sub. Ending 3-2-A runs.`n")
			flag_retreat := 1
			} else {
				DebugLog("Repair slots detected, we don't need to end 3-2-A runs.`n")
				} 
	}
	
repair() {
	DebugLog("Checking overview for ship girls that need repairing`n")
	kcv_repair_check() ; check if we're on overview > fleet 1 

	; now we must check each ship girl to determine how many critically damaged ship girls there are 
	; this can go two directions 
	; 1. We only have to repair the sub. In which case we use old repair method. 
	; 2. We have to repair some other ship girls and use buckets. 
	
	if (1to5_ships_check() = 1) { ; we need to repair some non-subs 
		DebugLog("A non-sub ship girl is damaged. Running new method.`n")
		; new repair method  
		repair_count() ; count using KCV how many ship girls need to be repaired 
		
		while (repair_count() >= 1) {
			DebugLog("Loop`n") ; remove when done 
			flag_repaired := 0
			flag_usingbucket := 0 ; for using buckets 
			repair_screen_open_check() ; a repair slot clicked now 
			; check each slot in order 
			repair_top6_list_check()
			Rand_Sleep(1000,2000)
			if (flag_slot1_needs_repair = 1) {
				DebugLog("Checking slot 1`n")
				Rand_ControlClick(416,174,765,196) ;; click slot 1 of repair list
				if (repair_count() > 1) { ; if we need to repair more than one ship girl 
					if (sub_check() = 1) { ; check if this is a sub girl 
						Rand_ControlClick(108,168,568,497) ;; click to exit this screen
						Rand_Sleep(500,2000)
						} else { ; if its not a sub 
						DebugLog("This is not a sub. Repairing...`n")
						hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
						repair_yes() 
						}
					} else { ; we're pretty sure it'll be a sub
					hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
					repair_yes() 
					}
				}
			repair_screen_open_check()
			if (flag_slot2_needs_repair = 1 and flag_repaired = 0) {
				DebugLog("Checking slot 2`n")
				Rand_ControlClick(419,209,758,227) ;; click slot 2 of repair list
				if (repair_count() > 1) { ; if we need to repair more than one ship girl 
					if (sub_check() = 1) { ; check if this is a sub girl 
						Rand_ControlClick(108,168,568,497) ;; click to exit this screen
						Rand_Sleep(500,2000)
						} else { ; if its not a sub 
						DebugLog("This is not a sub. Repairing...`n")
						hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
						repair_yes()
						}
					} else { ; we're pretty sure it'll be a sub
					hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
					repair_yes()
					}
				} 
			repair_screen_open_check()
			if (flag_slot3_needs_repair = 1 and flag_repaired = 0) {
				DebugLog("Checking slot 3`n")
				Rand_ControlClick(423,243,756,257) ;; click slot 3 of repair list
				if (repair_count() > 1) { ; if we need to repair more than one ship girl 
					if (sub_check() = 1) { ; check if this is a sub girl 
						Rand_ControlClick(108,168,568,497) ;; click to exit this screen
						Rand_Sleep(500,2000)
						} else { ; if its not a sub 
						DebugLog("This is not a sub. Repairing...`n")
						hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
						repair_yes()
						}
					} else { ; we're pretty sure it'll be a sub
					hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
					repair_yes()
					}
				}
			repair_screen_open_check()
			if (flag_slot4_needs_repair = 1 and flag_repaired = 0) { 
				DebugLog("Checking slot 4`n")
				Rand_ControlClick(420,271,759,290) ;; click slot 4 of repair list
				if (repair_count() > 1) { ; if we need to repair more than one ship girl 
					if (sub_check() = 1) { ; check if this is a sub girl 
						Rand_ControlClick(108,168,568,497) ;; click to exit this screen
						Rand_Sleep(500,2000)
						} else { ; if its not a sub 
						DebugLog("This is not a sub. Repairing...`n")
						hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
						repair_yes()
						}
					} else { ; we're pretty sure it'll be a sub
					hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
					repair_yes()
					}
				}
			repair_screen_open_check()
			if (flag_slot5_needs_repair = 1 and flag_repaired = 0) { 
				DebugLog("Checking slot 5`n")
				Rand_ControlClick(422,303,753,320) ;; click slot 5 of repair list 
				if (repair_count() > 1) { ; if we need to repair more than one ship girl 
					if (sub_check() = 1) { ; check if this is a sub girl 
						Rand_ControlClick(108,168,568,497) ;; click to exit this screen
						Rand_Sleep(500,2000)
						} else { ; if its not a sub 
						DebugLog("This is not a sub. Repairing...`n")
						hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
						repair_yes()
						}
					} else { ; we're pretty sure it'll be a sub
					hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
					repair_yes()
					}
				}
			repair_screen_open_check()
			if (flag_slot6_needs_repair = 1 and flag_repaired = 0) { 
				DebugLog("Checking slot 6`n")
				Rand_ControlClick(418,332,758,353) ;; click slot 6 of repair list 
				if (repair_count() > 1) { ; if we need to repair more than one ship girl 
					if (sub_check() = 1) { ; check if this is a sub girl 
						Rand_ControlClick(108,168,568,497) ;; click to exit this screen
						Rand_Sleep(500,2000)
						} else { ; if its not a sub 
						DebugLog("This is not a sub. Repairing...`n")
						hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
						repair_yes()
						}
					} else { ; we're pretty sure it'll be a sub
					hour_time_check() ; check if repair will take more than an hour , if not then use a bucket 
					repair_yes()
					}
				}
			if (repair_count() = 0) {
				Break ; end loop if no more ships need repairing 
				}
		}
		
		;
		;
		;
		} else if (ship_girl_6_check() = 1) { ; only sub needs to be repaired 
		DebugLog("Only a sub needs to be repaired. Running old method.`n")
		flag_subneedsreplacing := 1 ; need to replace the sub, not sure if its triped in the ship girl 6 check but it should be 
		;
		; old repair method starts here. 
		;
		if (repair_check() = 1) { ; check if any repair slots are open
		if (flag_repair_slot1_free = 1) {
			Rand_ControlClick(187,197,335,226) ;; slot 1
			Sleep 100
			} else if (flag_repair_slot2_free = 1) {
				Rand_ControlClick(184,277,335,309) ;; slot 2
				Sleep 100
				} else if (flag_repair_slot3_free = 1) {
					Rand_ControlClick(185,359,335,391) ;; slot 3
					Sleep 100
					} else if (flag_repair_slot4_free = 1) {
						Rand_ControlClick(186,439,336,469) ;; slot 4
						Sleep 100
						} 	
	
		; under the assumption that when this is run there will always be a free slot (repair_check() = 1) before this. 
		rand_sleep(1500,2000)
		repair_top6_list_check() ; scan for how many ships need repairing 

		; go in order, which ship has the most damage?
			if (flag_slot1_needs_repair = 1) {
				Rand_ControlClick(416,174,765,196) ;; click slot 1 of repair list
				repair_yes()
				} else if (flag_slot2_needs_repair = 1) {
					Rand_ControlClick(419,209,758,227) ;; click slot 2 of repair list
					repair_yes()
					} else if (flag_slot3_needs_repair = 1) {
						Rand_ControlClick(423,243,756,257) ;; click slot 3 of repair list
						repair_yes()
						} else if (flag_slot4_needs_repair = 1) { 
							Rand_ControlClick(420,271,759,290) ;; click slot 4 of repair list
							repair_yes()
							}
			} 
		rand_sleep(3000,5000)
		}
			
	}
	
; related to finding a new sub to use 

sub_search() { ; checks if this is a sub not repairing or on expedition
	sub_ok := 0 
	Sleep 2000
	Coordmode Pixel
	ImageSearch, repairX, repairY, -1080, 191, -905, 248, images/sub_search_1.bmp ; i-168
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1080, 191, -905, 248, images/sub_search_2.bmp ; i-19 
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1080, 191, -905, 248, images/sub_search_3.bmp ; i-8
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
	ImageSearch, repairX, repairY, -1080, 191, -905, 248, images/sub_search_4.bmp ; i-56
		if (ErrorLevel = 0) {
		sub_ok := 1 
		} 
		if (sub_ok = 1) { ; only one success is required
		Sleep 1000
		Rand_ControlClick(659,480,738,504) ;; hit the switch kanmusu button
		Rand_Sleep(2000,4000)
		flag_kanmusu_set := 1
		return
		} else {
		Rand_ControlClick(116,156,579,499) ;; click to exit kanmusu screen
		Sleep 2500
		flag_ten_counter += 1
		sub_number += 1
		}
	}
	
switch_button_search() { ; search if the replace kanmusu button is present 
	Sleep 1500
	ImageSearch, switchX, switchY, -1080, 449, -900, 520, images/switch_button.bmp 
		if (ErrorLevel = 0) {
		Rand_ControlClick(116,156,579,499) ;; click to exit kanmusu screen
		Sleep 1000
		} 
	Sleep 1500
	}
	
select_new_sub() { ; select a new sub 
	Rand_ControlClick(550,490,560,501) ;; click page 2 
	Sleep 2000
	; first lets random a number between 1-20, we will use subs on page 2 and 3 exclusively 
	sub_number := 1
	Random, sub_number, 1, 20
	; Msgbox Sub Number = %sub_number% ; used for debugging purposes 
	flag_kanmusu_set := 0
	flag_ten_counter := 0
	
		while (flag_kanmusu_set == 0)
		{
			if (sub_number > 10 and flag_ten_counter = 0) {
				Sleep 1000
				DebugLog("Sub number over 10, switch to page 3.`n")
				Rand_ControlClick(577,490,587,505) ;; click page 3 
				Sleep 1000
				} else if (flag_ten_searched = 1) {
				Msgbox could not find usable sub
				}
			if (sub_number = 11) {
				DebugLog("11`n")
				switch_button_search()
				Rand_ControlClick(410,207,726,226) ;; click slot 1 
				sub_search()
				}
			if (sub_number = 12) {
				DebugLog("12`n")
				switch_button_search()
				Rand_ControlClick(406,235,711,253) ;; click slot 2 
				sub_search()
				}
			if (sub_number = 13) {
				DebugLog("13`n")
				switch_button_search()
				Rand_ControlClick(407,262,734,281) ;; click slot 3 
				sub_search()
				}
			if (sub_number = 14) {
				DebugLog("14`n")
				switch_button_search()
				Rand_ControlClick(409,291,741,308) ;; click slot 4 
				sub_search()
				}
			if (sub_number = 15) {
				DebugLog("15`n")
				switch_button_search()
				Rand_ControlClick(408,318,738,338) ;; click slot 5
				sub_search()
				}
			if (sub_number = 16) {
				DebugLog("16`n")
				switch_button_search()
				Rand_ControlClick(405,346,722,366) ;; click slot 6 
				sub_search()
				}
			if (sub_number = 17) {
				DebugLog("17`n")
				switch_button_search()
				Rand_ControlClick(403,374,740,394) ;; click slot 7 
				sub_search()
				}
			if (sub_number = 18) {
				DebugLog("18`n")
				switch_button_search()
				Rand_ControlClick(406,403,743,422) ;; click slot 8 
				sub_search()
				}
			if (sub_number = 19) {
				DebugLog("19`n")
				switch_button_search()
				Rand_ControlClick(412,430,730,449) ;; click slot 9 
				sub_search()
				}
			if (sub_number = 20) {
				DebugLog("20`n")
				switch_button_search()
				Rand_ControlClick(410,461,733,476) ;; click slot 10 
				sub_search()
				}
			if (sub_number = 21 and flag_ten_counter < 20) {
				DebugLog("Sub number over 21, switch to page 2`n")
				Rand_ControlClick(550,490,560,501) ;; click page 2 
				sub_number := 1
				Sleep 1000
				} else if (flag_ten_searched >= 20) {
				Msgbox could not find usable sub
				}
			if (sub_number = 1) {
				DebugLog("1`n")
				switch_button_search()
				Rand_ControlClick(410,207,726,226) ;; click slot 1 
				sub_search()
				}
			if (sub_number = 2) {
				DebugLog("2`n")
				switch_button_search()
				Rand_ControlClick(406,235,711,253) ;; click slot 2 
				sub_search()
				}
			if (sub_number = 3) {
				DebugLog("3`n")
				switch_button_search()
				Rand_ControlClick(407,262,734,281) ;; click slot 3 
				sub_search()
				}
			if (sub_number = 4) {
				DebugLog("4`n")
				switch_button_search()
				Rand_ControlClick(409,291,741,308) ;; click slot 4 
				sub_search()
				}
			if (sub_number = 5) {
				DebugLog("5`n")
				switch_button_search()
				Rand_ControlClick(408,318,738,338) ;; click slot 5
				sub_search()
				}
			if (sub_number = 6) {
				DebugLog("6`n")
				switch_button_search()
				Rand_ControlClick(405,346,722,366) ;; click slot 6 
				sub_search()
				}
			if (sub_number = 7) {
				DebugLog("7`n")
				switch_button_search()
				Rand_ControlClick(403,374,740,394) ;; click slot 7 
				sub_search()
				}
			if (sub_number = 8) {
				DebugLog("8`n")
				switch_button_search()
				Rand_ControlClick(406,403,743,422) ;; click slot 8 
				sub_search()
				}
			if (sub_number = 9) {
				DebugLog("9`n")
				switch_button_search()
				Rand_ControlClick(412,430,730,449) ;; click slot 9 
				sub_search()
				}
			if (sub_number = 10) {
				DebugLog("10`n")
				switch_button_search()
				Rand_ControlClick(410,461,733,476) ;; click slot 10 
				sub_search()
				}
			if (sub_number = 11 and flag_ten_counter = 0) {
				DebugLog("Sub number 11, switch to page 3`n")
				Rand_ControlClick(577,490,587,505) ;; click page 3 
				Sleep 1000
				} else if (flag_ten_searched >= 20) {
				DebugLog("Searched 20 times, couldn't find suitable sub.`n")
				Msgbox could not find usable sub
				}
		}
	}














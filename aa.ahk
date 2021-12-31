;FFXIV AntiAFK/AntiQUEUE written by tayzo v1.0.0
#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

;lazy global scope
Global toggle

;ui stuff
Gui, Show,w80 h85, FFXIV AA
Gui, Add, Button, x12 y10 w50 h20 gHelp_Button, Help
Gui, Add, Button, x12 y35 w50 h20 gToggle_Button, Toggle
Gui, Add, Text, x5 y60 r1 w70 +cDA4F49 vIs_Running, Not Running
Gui +AlwaysOnTop -Resize -MaximizeBox -MinimizeBox

;look for and send input only to game
winclass = FFXIVGAME
SetTitleMatchMode, 2

;randomize keypress and release time
Random, rand1, 1, 10
SetKeyDelay, 0, %rand1%

;ensure hotkey press are picked up
#MaxThreadsPerHotkey 2

;main toggle function, toggle script on and off
ToggleLoop() {
	toggle:=!toggle
	if (toggle==true) {
		;change color and text of running indicator
		GuiControl, +c004FFF, Is_Running
		GuiControl,,Is_Running,Running
	}
	else {
		;change color and text of running indicator
		GuiControl, +cDD4444, Is_Running
		GuiControl,,Is_Running,Not Running
	}
}

;main loop, check toggle state and execute movement
loop {
	While toggle{
		AutoMovement(winclass)
	}
}

;main movement function
AutoMovement(winclass) {
		;randomize keypress and keyrelease time
		Random, rand, 100, 250
		SetKeyDelay, 0, %rand%
		ControlSend,,{w},  ahk_class %winclass%
		
		;random time between keypresses
		Random, rand2, 240000, 300000
		Sleep %rand2%
}

;controls the help button popup
Help_Button:
	MsgBox, Script presses the W key for a short period randomly at between 4 and 5 minute intervals`nWorks with the game in the background`nF12 or button to toggle the script`nctrl+q to close
return

;controls the toggle button
Toggle_Button:
	ToggleLoop()
return

;handles f12 hotkey
F12::
	;toggle the script
	ToggleLoop()
Return

;ensure the script exits if gui closes
GuiClose:
	ExitApp
return

;handles ctrl+q hotkey
^q::
ExitApp
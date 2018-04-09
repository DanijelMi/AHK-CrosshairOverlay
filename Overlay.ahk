#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force

;By danijelM
;github.com/DanijelMi

; Reads user settings from the previous session, if exists.
	Iniread, CrossImgRead, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Image
	Iniread, ImgSizeRead, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Size
	Iniread, xPosRead, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, Xs
	Iniread, yPosRead, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, Y

; Creates the settings GUI window
	tgl = 0
	Gui, add, button, default w50 h30 y55 x190, Run
	Gui, add, Edit, r1 gUpdateImg vCrossImg w100 y10 x5, %CrossImgRead%
	Gui, add, text,y6 x110 , Full or relative path to crosshair image. `nSupported files: GIF, JPG, BMP, ICO, CUR, ANI
	Gui, add, Edit, r1 gUpdateImgSize vImgSize Number w50 x5 y34, %ImgSizeRead%
	Gui, add, Text, x60 y37,Image size
	Gui, add, Edit, r1 gUpdateXPos vxPos Number w34 x5 y60, %xPosRead%
	Gui, add, Text, x41 y62 ,X Position
	Gui, add, Edit, r1 gUpdateYPos vyPos y60 x90 w34 Number, %yPosRead%
	Gui, add, Text, x126 y62,Y Position
	Gui, add, Text, x4 y90, Replace ERROR with values.
	Gui, add, Button, x320 y55 h30 w50,Close
	Gui, add, Text, y91 x160, Ctrl-R: Toggle 
	Gui, show, w400 h110,Dane's Overlay
return


; Image file path GUI element action
UpdateImg:
	Gui, submit, NoHide
	Iniwrite, %CrossImg%, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Image
return

; Image size GUI element action
UpdateImgSize:
	Gui, submit, NoHide
	Iniwrite, %ImgSize%, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Size
return

; Image X position GUI element action
UpdateXPos:
	Gui, submit, NoHide
	Iniwrite, %xPos%, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, X
return

; Image Y position GUI element action
UpdateYPos:
	Gui, submit, NoHide
	Iniwrite, %yPos%, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, Y
return

; CTRL-R to toggle off-on the overlay
^R::
	tgl := 1-tgl
	if tgl = 1
		Gui 2:Hide
	else if tgl = 0
		Gosub, ButtonRun
	return

ButtonRun:	; Run crosshair button action
{
	Gui Hide
	Gui 2:Default
	Gui, submit
	Iniread, CrossImgRead, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Image
	Iniread, ImgSizeRead, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Size
	Iniread, ReloadRead, %A_WorkingDir%\CrossHair_Options.ini, Controls, Reload
	Iniread, xPosRead, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, X
	Iniread, yPosRead, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, Y

	xPosRead -= ImgSizeRead/2
	yPosRead -= ImgSizeRead/2

	Gui, Color, FFFFFF
	Gui, Font, S12, Arial Black
	Gui +LastFound +AlwaysOnTop +ToolWindow -caption
	WinSet, TransColor, FFFFFF
	Gui, Add, Picture, altsubmit w%ImgSizeRead% h-1 +BackgroundTrans, %CrossImgRead%
	Gui, show, y%yPosRead% x%xPosRead% NoActivate, Overlay
	WinSet, ExStyle, +0x00000020, Overlay
	WinSet, Transparent, 0, ahk_id %hWnd%
	return
}

ButtonClose:	; Close button action
	ExitApp	

+^f1::Reload	;Reload the entire script (ctrl-shift-f1)
	return


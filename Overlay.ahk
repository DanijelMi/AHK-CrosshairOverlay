#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
#SingleInstance, Force



Iniread, CrossImgRead, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Image
Iniread, ImgSizeRead, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Size
Iniread, xPosRead, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, X
Iniread, yPosRead, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, Y
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



UpdateImg:
Gui, submit, NoHide
Iniwrite, %CrossImg%, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Image
return

UpdateImgSize:
Gui, submit, NoHide
Iniwrite, %ImgSize%, %A_WorkingDir%\CrossHair_Options.ini, Crosshair, Size
return

UpdateXPos:
Gui, submit, NoHide
Iniwrite, %xPos%, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, X
return

UpdateYPos:
Gui, submit, NoHide
Iniwrite, %yPos%, %A_WorkingDir%\CrossHair_Options.ini, Coordinates, Y
return


^R::
{
if tgl = 0
		{
		tgl = 1
		Gui 2:Hide
		return
		}
		else if tgl = 1
		{
		Gosub, ButtonRun
		tgl = 0
		return
		}
}



ButtonRun:
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
ButtonClose:
{
ExitApp	
}


+^f1::Reload
return


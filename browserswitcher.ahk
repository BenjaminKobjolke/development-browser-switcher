;
; AutoHotkey Version: 1.x
; Language:       English
; Platform:       Win9x/NT
; Author:         A.N.Other <myemail@nowhere.com>
;
; Script Function:
;	Template script (you can customize this template by editing "ShellNew\Template.ahk" in your Windows folder)
;
#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Persistent  ; Keep the script running until the user exits it.
#SingleInstance force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetTitleMatchMode 2
SetWorkingDir, %A_ScriptDir%

parameter = %1%

if(parameter = "close") {	
	ExitApp
}
version = 0.3
;INIREAD START
	IniRead, browser, settings.ini, settings, browser
	IniRead, custom, settings.ini, settings, custom
	IniRead, upload, settings.ini, settings, upload
	IniRead, macro, settings.ini, settings, macro
	IniRead, ide, settings.ini, settings, ide
	IniRead, customide, settings.ini, settings, customide
;INIREAD END	

;MENUTRAY START	
	Menu, tray, NoStandard
	Menu, tray, add, BrowserSwitcher 0.3, nothing
	Menu, tray, disable, BrowserSwitcher 0.3
	Menu, tray, add  ; Creates a separator line.
	Menu, tray, add, Chrome, browserChrome	
	Menu, tray, add, Brave, browserBrave
	Menu, tray, add, Firefox, browserFF
	Menu, tray, add, Opera, browserOpera
	Menu, tray, add, Safari, browserSafari
	Menu, tray, add, Custom, browserCustom
	
	Menu, tray, add  ; Creates a separator line.
	Menu, tray, add, Notepad++ upload, notepad
	if(!A_IsCompiled) {
		Menu, tray, add, Macro Switch Method, macro
	}
	Menu, tray, add  ; Creates a separator line.
	Menu, tray, add, Setup, SetupProgramm ; Creates a new menu item.
	Menu, tray, add, Visit Website, VisitWebsite ; Creates a new menu item.
	Menu, tray, add,
	Menu, tray, add, Exit, ExitProgramm ; Creates a new menu item.
	Menu, tray, Icon , knob_off.ico, 1
;MENUTRAY END

	setTray(browser, upload, macro)
	
;Set Setup Menu to settings of ini

	if (browser = "Chrome") {
		radiochecked1 = checked
	} else if (browser = "Brave") {
		radiochecked2 = checked
	} else if (browser = "Firefox") {
		radiochecked3 = checked
	} else if (browser = "Opera") {
		radiochecked4 = checked
	} else if (browser = "Safari") {
		radiochecked5 = checked
	}  else {
		radiochecked6 = checked
		customtext = %custom%
	}
	
	if (ide = "Notepad++") {
		radioIDEchecked1 = checked
	} else if (ide = "Eclipse") {
		radioIDEchecked2 = checked
	} else if (ide = "Visual Studio") {
		radioIDEchecked3 = checked
	} else {
		radioIDEchecked4 = checked
		customIDEtext = %customide%
	}	

	if (upload = 1) {
		notepadchecked = checked
	} 	
	
;GUI START
	Gui, Add, Tab, w320 h230 , Setup | Extras | About
	;Gui, Add, Tab, w320 h230 , Setup | About
	Gui, font, s10 bold, Verdana
	Gui, Add, Text, x26 y40 w80 h20 , Browser	
	Gui, Add, Text, x210 y40 w80 h20 , IDE
	Gui, font, s9 norm, Verdana

	Gui, Add, Radio, %radiochecked1% vBrowserRadio1 x26 y60 w130 h20 , Chrome
	Gui, Add, Radio, %radiochecked2% vBrowserRadio2 x26 y80 w130 h20 , Brave	
	Gui, Add, Radio, %radiochecked3% vBrowserRadio3 x26 y100 w130 h20 , Firefox
	Gui, Add, Radio, %radiochecked4% vBrowserRadio4 x26 y120 w130 h20 , Opera
	Gui, Add, Radio, %radiochecked5% vBrowserRadio5 x26 y140 w130 h20 , Safari
	Gui, Add, Radio, %radiochecked6% vBrowserRadio6 x26 y170 w130 h20 , Custom	
	Gui, Add, Edit,  vcustombrowser x26 y190 w110 h20 , %customtext%
	
	Gui, Add, Radio, %radioIDEchecked1% vIDERadio1 x210 y60 w110 h20 , Notepad++
	Gui, Add, Radio, %radioIDEchecked2% vIDERadio2 x210 y80 w110 h20 , Eclipse
	Gui, Add, Radio, %radioIDEchecked3% vIDERadio3 x210 y100 w110 h20 , Visual Studio
	Gui, Add, Radio, %radioIDEchecked4% vIDERadio4 x210 y170 w110 h20 , Custom	
	Gui, Add, Edit,  vcustomide x210 y190 w110 h20 , %customIDEtext%	
	
	Gui, Add, Button, default x230 y250 w100 h30 , Save 
	
	
	Gui, Tab, 2	
	
	Gui, Add, Button, default x230 y250 w100 h30 , Save
	
	Gui, font, s10 bold, Verdana
	Gui, Add, GroupBox, x25 y35 w280 h150, Notepad++ Integration
	;Gui, Add, Text, x26 y40 w180 h20 , Notepad++ Integration
	Gui, font, s9 norm, Verdana
	
	Gui, Add, CheckBox, %notepadchecked% vNotepad x36 y60 w140 h20 , Enable Integration	
	Gui, font, s8 norm, Verdana
	Gui, Add, Text, x36 y80  w260 , If you use Notepad++ and the FTP Plugin enabling this will tell BrowserSwitcher to wait for the upload to complete before it changes to the browser.
	
	Gui, Tab, 3
	Gui, font, s10 bold, Verdana
	Gui, Add, GroupBox, x25 y35 w280 h150, BrowserSwitcher v%version%
	;Gui, Add, Text, x26 y40 w180 h20 , Notepad++ Integration
	Gui, font, s8 norm, Verdana
	Gui, Add, Text, x36 y60  w260 , This program is copyright by "Benjamin Kobjolke".`n`nIt is freeware for personal and commercial use. However you are not allowed to sell this software.	
;GUI END
	
return

GuiClose:
ButtonSave:
	Gui, Submit  ; Save each control's contents to its associated variable.	
	
	if (BrowserRadio6 = 1) {
		browser = CUSTOM
	} else if (BrowserRadio1 = 1) {
		browser = Chrome
	} else if (BrowserRadio2 = 1) {
		browser = Brave
	} else if (BrowserRadio3 = 1) {
		browser = Firefox
	} else if (BrowserRadio4 = 1) {
		browser = Opera
	} else if (BrowserRadio5 = 1) {
		browser = Safari
	}
	
	if (IDERadio4 = 1) {
		ide = CUSTOM		
	} else if (IDERadio1 = 1) {
		ide = Notepad++
	} else if (IDERadio2 = 1) {
		ide = Eclipse
	} else if (IDERadio3 = 1) {
		ide = Visual Studio
	}

	if (Notepad = 1) {
		upload = %Notepad%
	} else {
		upload = 0
	}


	setTray(browser, upload, macro)
	IniWrite, %browser%, settings.ini, settings, browser
	IniWrite, %custombrowser%, settings.ini, settings, custom
	IniWrite, %ide%, settings.ini, settings, ide
	IniWrite, %customide%, settings.ini, settings, customide	
	IniWrite, %upload%, settings.ini, settings, upload
	
return	

browserBrave:
	browser = Brave
	IniWrite, %browser%, settings.ini, settings, browser
	GuiControl, , BrowserRadio2, 1
	
	setTray(browser, upload, macro)
return

browserFF:
	browser = Firefox
	IniWrite, %browser%, settings.ini, settings, browser
	GuiControl, , BrowserRadio3, 1
	
	setTray(browser, upload, macro)
return

browserOpera:
	browser = Opera
	IniWrite, %browser%, settings.ini, settings, browser
	GuiControl, , BrowserRadio4, 1
	
	setTray(browser, upload, macro)	
return

browserSafari:
	browser = Safari
	IniWrite, %browser%, settings.ini, settings, browser
	GuiControl, , BrowserRadio5, 1
	
	setTray(browser, upload, macro)	
return

browserChrome:
	browser = Chrome
	IniWrite, %browser%, settings.ini, settings, browser
	GuiControl, , BrowserRadio1, 1
	
	setTray(browser, upload, macro)	
return

browserCustom:
	browser = Custom
	IniWrite, %browser%, settings.ini, settings, browser	
	GuiControl, , BrowserRadio6, 1
	
	setTray(browser, upload, macro)
return

macro:
	if(macro = 1) {
		macro = 0
	} else {
		macro = 1
	}			
	IniWrite, %macro%, settings.ini, settings, macro
	
	setTray(browser, upload, macro)
return

notepad:
	if(upload = 1) {
		GuiControl, , Notepad, 0
		upload = 0
	} else {
		GuiControl, , Notepad, 1
		upload = 1
	}		
	
	IniWrite, %upload%, settings.ini, settings, upload
	
	setTray(browser, upload, macro)
return

nothing:
return

SetupProgramm:  
	Gui, Show, x435 y235 h290 w340, BrowserSwitcher v%version% - Settings
return

activateBrowser: 
	if(macro = 1) { 
		#Include %A_ScriptDir%\macro.ahk
		return
	} 			


	IfWinExist, %browsertitle%  
	{
		WinActivate ,  %browsertitle% 	  
		Send {F5}			
	} else
	{
		MsgBox, Can not find your choosen browser, please check if the browser is running.
	}	
	/*
	StatusBarWait , Uploading, 5, 2, Notepad++
	if ErrorLevel
	{
		TrayTip ,,
		MsgBox, Upload took too long.`nCheck your internet settings or rise the upload waiting time in the Setup menu. 
		IfMsgBox, OK 				
			return
	} 
		 
	StatusBarWait , Upload succeeded, 5, 2, Notepad++			
	if ErrorLevel
	{
		TrayTip ,,
		MsgBox, Upload took too long.`nCheck your internet settings or rise the upload waiting time in the Setup menu. 
		IfMsgBox, OK 
			return 
	}
	
	TrayTip ,,
	*/ 
	
return
 
;SetTimer, PushTheButton, 150

^s::    
	TrayTip ,, 
	errormsg = 
	
	if(browser = "CUSTOM") {
		browsertitle = %custombrowser% 
	} else {
		browsertitle = %browser% 
	}	
	
	if(ide = "CUSTOM") {
		idetitle = %customide%
	} else {
		idetitle = %ide%
	}
	
	execute = 0
	IfWinActive, %idetitle%
	{
		Hotkey, ^s, Off
		Send ^s
		Hotkey, ^s, On		
		Menu, tray, Icon , knob_off.ico, 1
		execute = 1
	} else IfWinActive, %browsertitle%
	{
		Menu, tray, Icon , knob_on.ico, 1
		execute = 1
	} else {
		Hotkey, ^s, Off
		Send ^s
		Hotkey, ^s, On			
	}
	
	IfWinNotExist, %idetitle%
	{
		errormsg = Can not find your choosen IDE, please check if the ide is running.`n
		execute = 0
	}
	
	IfWinNotExist, %browsertitle%
	{ 
		errormsg = %errormsg%Can not find your choosen browser, please check if the browser is running.`n
		execute = 0
	}
	
	if(execute = 1) {
		IfWinActive, %idetitle%
		{  
			WinGetTitle, this_title, A
			Needle = *  
			StringGetPos, pos, this_title, %Needle% 
			if (pos = -1 && upload = 1) {
				TrayTip, Notepad++ Integration, No File changes...,10
				goSub, activateBrowser
			} else {
				Send ^s
				if(upload = 1) {   
					TrayTip , Notepad++ Integration, Waiting for file upload...
					SetTimer, waitForUploadPhase1, 150
				} else {			
					goSub, activateBrowser 
				}
			}
		} else IfWinActive, %browsertitle%
		{				
			IfWinExist, %idetitle% 
			{ 
				WinActivate , %idetitle%			 
			} else
			{
				MsgBox, Can not find your choosen IDE, please check if the ide is running.
			}
		} else { 
			Send ^s
		}	
	} else {
		;MsgBox, %execute%
		if(errormsg != "") {
			MsgBox, %errormsg%
		} else if(execute = 0) {
			Send {Control Down}s{Control Up}
		}
	}

return

waitForUploadPhase1:
	ControlGet, output, List, Count, SysListView321, - Notepad++
	if(output = 1) {
		;TrayTip, Status, count is no %output%
		SetTimer, waitForUploadPhase1, Off
		SetTimer, waitForUploadPhase2, 150
	}
return

waitForUploadPhase2:
	ControlGet, output, List, Count, SysListView321, - Notepad++
	if(output = 0) {
		TrayTip, Status, count is no %output%
		SetTimer, waitForUploadPhase2, Off
		TrayTip, ,	
		goSub, activateBrowser	
			
	}	
return

/*
PushTheButton:
	IfWinExist, Confirm
	{
		WinActivate, Confirm
		Send {Enter}
	}
return
*/

VisitWebsite:
	run, https://github.com/BenjaminKobjolke/development-browser-switcher
return

ReloadProgramm:
	reload
return

ExitProgramm:
	ExitApp
return

;Set Tray Menu to settings of ini
setTray(browser, upload, macro) {
	Menu, tray, Uncheck, Brave
	Menu, tray, Uncheck, Firefox
	Menu, tray, Uncheck, Opera
	Menu, tray, Uncheck, Safari
	Menu, tray, Uncheck, Chrome
	Menu, tray, Uncheck, Custom	
	Menu, tray, Uncheck, Notepad++ upload
	if(!A_IsCompiled) {	
		Menu, tray, Uncheck, Macro Switch Method
	}
	
	;M sgBox, %browser%
	if (browser = "Internet Explorer") {
		Menu, tray, Check, Internet Explorer
	} else if (browser = "Firefox") {
		Menu, tray, Check, Firefox		
	} else if (browser = "Opera") {
		Menu, tray, Check, Opera
	} else if (browser = "Safari") {
		Menu, tray, Check, Safari
	} else if (browser = "Chrome") {
		Menu, tray, Check, Chrome
	} else if (browser = "Brave") {
		Menu, tray, Check, Brave
	} else {
		Menu, tray, Check, Custom
	}
	
	if (upload = 1) {
		Menu, tray, Check, Notepad++ upload
	}
	if (macro = 1) {
		Menu, tray, Check, Macro Switch Method
	}
}

/*
if(!A_IsCompiled) {
	#y::
		;ControlGetText, output , SysListView321, 
		;ControlGet, output, Line, 1, SysListView321, - Notepad++
		Send ^s
		reload
	return
}
*/
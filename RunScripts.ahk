#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On

; Exit all scripts
WinGet, ID, List, ahk_class AutoHotkey
Loop, %ID%
{
    ThisID := ID%A_Index%
    If (ThisID != A_ScriptHwnd)
        PostMessage, 0x0111, 65307,,, % "ahk_id " ThisID
}

; Run these scripts
Run, "CapsLock.ahk"
Run, "Dictionaries.ahk"
; Run, "RunOrRise.ahk"
Run, "SuperKey.ahk"
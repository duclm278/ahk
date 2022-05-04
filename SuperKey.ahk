#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On

RegRead, Workstation, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation
If (Workstation != 1)
{
    MsgBox, 0, Warning, Please DISABLE locking workstation!
    ExitApp
}

; Vim-like mappings
#If, GetKeyState("LWin", "P")
    *h::Left
    *j::Down
    *k::Up
    *l::Right
#If

; Reload all
#+r::
    WinGet, ID, List, ahk_class AutoHotkey
    Loop, %ID%
    {
        ThisID := ID%A_Index%
        WinGetTitle, Title, % "ahk_id " ThisID
        If (InStr(Title, A_ScriptFullPath) == 0)
            PostMessage, 0x0111, 65303,,, % "ahk_id " ThisID
    }
    Reload
Return

; Other mappings
#a::Winset, AlwaysOnTop,, A

#+q::WinClose, A
#+v::
    Clipboard = %Clipboard%
    Send, ^v
    Sleep, 50
Return
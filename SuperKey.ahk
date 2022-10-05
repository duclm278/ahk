#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On

; Simple keymaps
#j::Send, #{Down}
#k::Send, #{Up}

; Change desktops
#^h::Send, #^{Left}
#^l::Send, #^{Right}

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
#+q::WinClose, A
#+v::
    Clipboard = %Clipboard%
    Send, ^v
    Sleep, 50
Return
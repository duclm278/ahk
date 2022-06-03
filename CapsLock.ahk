#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On
SetCapsLockState, AlwaysOff

CapsLock::Send, {Esc}

CapsLock & a::Home
CapsLock & e::End
CapsLock & o::AppsKey

CapsLock & [::Esc
CapsLock & h::Left
CapsLock & j::Down
CapsLock & k::Up
CapsLock & l::Right

CapsLock & Space::
    If (GetKeyState("CapsLock", "T") == 0)
        SetCapsLockState, AlwaysOn
    Else
        SetCapsLockState, AlwaysOff

    KeyWait, Space
Return
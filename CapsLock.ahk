#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

ToggleCapsLock()
{
    SetCapsLockState, % !GetKeyState("CapsLock", "T")
    SoundBeep, 750, 500
    Return
}

*CapsLock::Return
#If, GetKeyState("CapsLock", "P")
    *a::Home
    *e::End

    *[::Esc
    *h::Left
    *j::Down
    *k::Up
    *l::Right

    *Enter::ToggleCapsLock()
#If
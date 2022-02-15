#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Run as administrator
If (!A_IsAdmin)
{
    Try
        Run *RunAs "%A_ScriptFullPath%" /restart
    ExitApp
}

RegRead, Hotkeys, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, DisabledHotkeys
If (ErrorLevel)
{
    RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, DisabledHotkeys, CT
    MsgBox, 0, Warning, You have DISABLED conflicting hotkeys!
}
Else
{
    If (Hotkeys == 0)
    {
        RegWrite, REG_SZ, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, DisabledHotkeys, CT
        MsgBox, 0, Warning, You have DISABLED conflicting hotkeys!
    }
    Else
    {
        RegDelete, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, DisabledHotkeys
        MsgBox, 0, Warning, You have ENABLED conflicting hotkeys!
    }
}
ExitApp
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

RegRead, DisableLockWorkstation, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation
If (ErrorLevel)
{
    RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
    MsgBox, 0, Warning, You have DISABLED locking workstation!
}
Else
{
    If (DisableLockWorkstation == 0)
    {
        RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 1
        MsgBox, 0, Warning, You have DISABLED locking workstation!
    }
    Else
    {
        RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Policies\System, DisableLockWorkstation, 0
        MsgBox, 0, Warning, You have ENABLED locking workstation!
    }
}
ExitApp
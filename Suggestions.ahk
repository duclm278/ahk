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

RegRead, Workstation, HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer, DisableSearchBoxSuggestions
If (ErrorLevel)
{
    RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer, DisableSearchBoxSuggestions, 1
    MsgBox, 0, Warning, You have DISABLED online suggestions!
}
Else
{
    If (Workstation == 0)
    {
        RegWrite, REG_DWORD, HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer, DisableSearchBoxSuggestions, 1
        MsgBox, 0, Warning, You have DISABLED online suggestions!
    }
    Else
    {
        RegDelete, HKEY_CURRENT_USER\Software\Policies\Microsoft\Windows\Explorer, DisableSearchBoxSuggestions
        MsgBox, 0, Warning, You have ENABLED online suggestions!
    }
}
ExitApp
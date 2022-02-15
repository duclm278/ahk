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

RegRead, Hotkeys, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, DisabledHotkeys
If (Hotkeys != "CT")
{
    MsgBox, 0, Warning, Please DISABLE conflicting hotkeys!
    ExitApp
}

RunOrRaiseRegularApps(ClassName, ProcessName, Target)
{
    ; Define matching criteria
    WinTitle := "ahk_class " ClassName " ahk_exe " ProcessName

    ; Create a unique window group
    SplitPath, ProcessName,,,, ProcessNameNoExt
    GroupName := ClassName ProcessNameNoExt
    GroupAdd, %GroupName%, %WinTitle%

    If (!WinExist(WinTitle))
        Run, %Target%
    Else If (WinActive(WinTitle))
        GroupActivate, %GroupName%, R
    Else
    {
        ; Windows are retrieved in order from topmost to bottommost
        WinGet, Windows, List, % "ahk_group " GroupName
        WinActivate, % "ahk_id " Windows%Windows%
    }
    Return
}

; Function parameters      #ClassName                       #ProcessName           #Target
#+f::RunOrRaiseRegularApps("CabinetWClass",                 "Explorer.EXE",        "explorer.exe")
#+w::RunOrRaiseRegularApps("Chrome_WidgetWin_1",            "chrome.exe",          "chrome.exe")
#+t::RunOrRaiseRegularApps("CASCADIA_HOSTING_WINDOW_CLASS", "WindowsTerminal.exe", "wt.exe")
#+Enter::Gosub, #+t

; Launch new apps
#f::Run, "explorer.exe"
#w::Run, "chrome.exe"
#t::Run, "wt.exe"
#Enter::Gosub, #t

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
        If InStr(Title, A_ScriptFullPath) == 0
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
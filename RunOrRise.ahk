#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On

RegRead, Hotkeys, HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced, DisabledHotkeys
If (InStr(Hotkeys, "T") == 0)
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
        ; Retrieve windows in order from topmost to bottommost
        WinGet, Windows, List, % "ahk_group " GroupName
        WinActivate, % "ahk_id " Windows%Windows%
    }
    Return
}

; Function parameters     #ClassName                       #ProcessName           #Target
#f::RunOrRaiseRegularApps("CabinetWClass",                 "Explorer.EXE",        "explorer.exe")
#w::RunOrRaiseRegularApps("Chrome_WidgetWin_1",            "chrome.exe",          "chrome.exe")
#t::RunOrRaiseRegularApps("CASCADIA_HOSTING_WINDOW_CLASS", "WindowsTerminal.exe", "wt.exe")

; Launch new apps
#+f::Run, "explorer.exe"
#+w::Run, "chrome.exe"
#+t::Run, "wt.exe"
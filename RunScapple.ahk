#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On

; Menu 1: General menu
global New                := 01
global Delete             := 02
global Copy               := 03
global Paste              := 04
global ApplyNoteStyle     := 05
global Border             := 06
global Connect            := 07
global ConnectAll         := 08
global ConnectWithArrow   := 09
global Disconnect         := 10
global Stack              := 11
global AutoFit            := 12
global Align              := 13
global Distribute         := 14
global MakeSameWidth      := 15
global MakeSameHeight     := 16
global BringToFront       := 17
global SendToBack         := 18
global Magnetic           := 19

; Menu 2: New
global NewBackgroundShape := 02

; Menu 2: Apply Note Style
global DefaultNoteStyle   := 01
global Big12              := 02
global Big14              := 03
global Big17              := 04
global Big20              := 05
global Big24              := 06
global BubbleBlue         := 07
global BubbleGreen        := 08
global BubblePink         := 09
global BubbleRed          := 10
global BubbleYellow       := 11
global Size500            := 12

; Menu 2: Align
global LeftEdges          := 01
global RightEdges         := 02
global TopEdges           := 03
global BottomEdges        := 04
global HorizontalCenters  := 05
global VerticalCenters    := 06

; Menu 2: Distribute
global Horizontally       := 01
global Vertically         := 02

Select(Option)
{
	Send, {Down %Option%}
	Send, {Enter}
}

RightClick(Option1, Option2)
{
    ; Quit insert mode
    If (A_Cursor == "IBeam")
        Send, {Esc}
    
    If (Option1 != 0)
    {
        Send, {AppsKey}
        Select(Option1)
        If (Option2 != 0)
            Select(Option2 - 1)
        Sleep, 50
    }

    Return
}

global Wait := 0
#If, WinActive("ahk_exe scapple.exe") && GetKeyState("LButton", "P") && Wait == 0
    1::RightClick(ApplyNoteStyle, Big12)
    2::RightClick(ApplyNoteStyle, Big14)
    3::RightClick(ApplyNoteStyle, Big17)
    4::RightClick(ApplyNoteStyle, Big20)
    5::RightClick(ApplyNoteStyle, Big24)
    0::RightClick(ApplyNoteStyle, DefaultNoteStyle)

    a::
        Wait := 1
        Input, Key, L1
        If (Key = "l")
            RightClick(Align, LeftEdges)
        Else If (Key = "r")
            RightClick(Align, RightEdges)
        Else If (Key = "t")
            RightClick(Align, TopEdges)
        Else If (Key = "b")
            RightClick(Align, BottomEdges)
        Else If (Key = "h")
            RightClick(Align, HorizontalCenters)
        Else If (Key = "v")
            RightClick(Align, VerticalCenters)
        Else
            MsgBox, You have pressed "a%Key%".
        Wait := 0
    Return
    b::
        Wait := 1
        Input, Key, L1
        If (Key = "b")
            RightClick(ApplyNoteStyle, BubbleBlue)
        Else If (Key = "g")
            RightClick(ApplyNoteStyle, BubbleGreen)
        Else If (Key = "p")
            RightClick(ApplyNoteStyle, BubblePink)
        Else If (Key = "r")
            RightClick(ApplyNoteStyle, BubbleRed)
        Else If (Key = "y")
            RightClick(ApplyNoteStyle, BubbleYellow)
        Else
            MsgBox, You have pressed "b%Key%".
        Wait := 0
    Return
    d::
        Wait := 1
        Input, Key, L1
        If (Key = "h")
            RightClick(Distribute, Horizontally)
        Else If (Key = "v")
            RightClick(Distribute, Vertically)
        Else
            MsgBox, You have pressed "d%Key%".
        Wait := 0
    Return
    f::RightClick(AutoFit, 0)
    m::^+m
    n::RightClick(New, NewBackgroundShape)
    s::
        Wait := 1
        Input, Key, L1
        If (Key = "h")
            RightClick(MakeSameHeight, 0)
        Else If (Key = "p")
            Send, ^k
        Else If (Key = "t")
            Send, ^'
        Else If (Key = "w")
            RightClick(MakeSameWidth, 0)
        Else
            MsgBox, You have pressed "s%Key%".
        Wait := 0
    Return
#If

; Other mappings
#+q::WinClose, A
#+r::Reload
#+v::
    Clipboard = %Clipboard%
    Send, ^v
    Sleep, 50
Return
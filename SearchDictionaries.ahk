#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On

#z::
    Send, ^c
    Sleep, 250
    Clipboard1 := Trim(Clipboard)
    Clipboard2 := Trim(Clipboard)
    StringUpper, Clipboard1, Clipboard1
    StringLower, Clipboard2, Clipboard2
    Clipboard3 := StrReplace(Clipboard2, A_Space, "+")
    MsgBox, 4, Dictionaries 1, Do a search on "%Clipboard1%"?
    IfMsgBox, No
        Return
    IfMsgBox, Yes
    {
        Run, chrome.exe --new-window "https://www.ldoceonline.com/search/direct/?q=%Clipboard3%"
        Sleep, 250
        Run, https://www.collinsdictionary.com/search/?dictCode=english&q=%Clipboard3%
        Sleep, 50
        Run, https://www.oxfordlearnersdictionaries.com/search/english/?q=%Clipboard3%
        Sleep, 50
        Run, https://dictionary.cambridge.org/search/english/direct/?q=%Clipboard3%
        Sleep, 50
        Run, https://learnersdictionary.com/definition/%Clipboard2%
        Sleep, 50
        Run, https://vi.wiktionary.org/wiki/%Clipboard2%
        Sleep, 50
		Run, https://www.google.com/search?q=%Clipboard3%&tbm=isch
        Sleep, 250
        Send, ^{Tab}
    }
    Send, +!{Left}
Return

#x::
    InputBox, Clipboard1, Dictionaries 2, Please enter a term., , 225, 125
    If (ErrorLevel == 1)
        Return
    Clipboard1 := Trim(Clipboard1)
    StringLower, Clipboard1, Clipboard1
    Clipboard2 := StrReplace(Clipboard1, A_Space, "+")
    Sleep, 250
    If (ErrorLevel == 0)
    {
        Run, chrome.exe --new-window "https://www.ldoceonline.com/search/direct/?q=%Clipboard2%"
        Sleep, 250
        Run, https://www.collinsdictionary.com/search/?dictCode=english&q=%Clipboard2%
        Sleep, 50
        Run, https://www.oxfordlearnersdictionaries.com/search/english/?q=%Clipboard2%
        Sleep, 50
        Run, https://dictionary.cambridge.org/search/english/direct/?q=%Clipboard2%
        Sleep, 50
        Run, https://learnersdictionary.com/definition/%Clipboard1%
        Sleep, 50
        Run, https://vi.wiktionary.org/wiki/%Clipboard1%
        Sleep, 50
		Run, https://www.google.com/search?q=%Clipboard2%&tbm=isch
        Sleep, 250
        Send, ^{Tab}
    }
    Send, +!{Left}
Return

#+z::
    Send, ^c
    Sleep, 250
    Clipboard1 := Trim(Clipboard)
    Clipboard2 := Trim(Clipboard)
    StringUpper, Clipboard1, Clipboard1
    StringLower, Clipboard2, Clipboard2
    Clipboard3 := StrReplace(Clipboard2, A_Space, "+")
    MsgBox, 4, Dictionaries 3, Do a search on "%Clipboard1%"?
    IfMsgBox, No
        Return
    IfMsgBox, Yes
    {
        Run, chrome.exe --new-window "https://www.lexico.com/en/definition/%Clipboard2%"
        Sleep, 250
        Run, https://www.etymonline.com/word/%Clipboard2%
        Sleep, 50
        Run, https://www.vocabulary.com/dictionary/%Clipboard2%
        Sleep, 50
        Run, https://www.google.com/search?q=define+%Clipboard3%
        Sleep, 250
        Send, ^{Tab}
    }
    Send, +!{Left}
Return

#+x::
    InputBox, Clipboard1, Dictionaries 4, Please enter a term., , 225, 125
    If (ErrorLevel == 1)
        Return
    Clipboard1 := Trim(Clipboard1)
    StringLower, Clipboard1, Clipboard1
    Clipboard2 := StrReplace(Clipboard1, A_Space, "+")
    Sleep, 250
    If (ErrorLevel == 0)
    {
        Run, chrome.exe --new-window "https://www.lexico.com/en/definition/%Clipboard1%"
        Sleep, 250
        Run, https://www.etymonline.com/word/%Clipboard1%
        Sleep, 50
        Run, https://www.vocabulary.com/dictionary/%Clipboard1%
        Sleep, 50
        Run, https://www.google.com/search?q=define+%Clipboard2%
        Sleep, 250
        Send, ^{Tab}
    }
    Send, +!{Left}
Return

; Other mappings
#+q::WinClose, A
#+r::Reload
#+v::
    Clipboard = %Clipboard%
    Send, ^v
    Sleep, 50
Return
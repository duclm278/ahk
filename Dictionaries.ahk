#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.

; Other settings
#SingleInstance, Force
#WinActivateForce
DetectHiddenWindows, On

; Set your browser
; global Browser := "brave.exe"
global Browser := "chrome.exe"

; Set your arguments
global History := "-incognito"
global Windows := "-new-window"

; Set your dictionaries
global Groups := []

Groups[1, 1] := "https://www.ldoceonline.com/search/direct/?q={2}"
Groups[1, 2] := "https://www.collinsdictionary.com/search/?dictCode=english&q={2}"
Groups[1, 3] := "https://www.oxfordlearnersdictionaries.com/search/english/?q={2}"
Groups[1, 4] := "https://dictionary.cambridge.org/search/english/direct/?q={2}"
Groups[1, 5] := "https://learnersdictionary.com/definition/{1}"
Groups[1, 6] := "https://vi.wiktionary.org/wiki/{1}"
Groups[1, 7] := "https://www.google.com/search?q={2}&tbm=isch"

Groups[2, 1] := "https://www.lexico.com/en/definition/{1}"
Groups[2, 2] := "https://www.etymonline.com/word/{1}"
Groups[2, 3] := "https://www.vocabulary.com/dictionary/{1}"
Groups[2, 4] := "https://www.google.com/search?q=define+{2}"

; Set your commands
ExecuteThis()
{
    Sleep, 750
    Send, +!h
    ; Send, +!l
    Return
}

Group2String(Dicts, Query1, Query2)
{
    String := ""
    Loop % Dicts.MaxIndex()
    {
        Dict := """" Dicts[A_Index] """"
        Dict := StrReplace(Dict, "{1}", Query1)
        Dict := StrReplace(Dict, "{2}", Query2)
        String := String " " Dict
    }

    String := SubStr(String, 2)
    Return String
}

Paste2Search(Index)
{
    Send, ^c
    Sleep, 250

    Term := Trim(Clipboard)
    StringUpper, Term, Term

    MsgBox, 4, Group %Index%, Do a search on "%Term%"?
    IfMsgBox, No
        Return

    Query1 := Trim(Term)
    StringLower, Query1, Query1
    Query2 := StrReplace(Query1, A_Space, "+")

    URLs := Group2String(Groups[Index], Query1, Query2)
    Run, % Browser " " History " " Windows " " URLs
    ExecuteThis()
    Return
}

Input2Search(Index)
{
    InputBox, Term, Group %Index%, Please enter a term:,, 225, 125
    If (ErrorLevel == 1)
        Return

    Query1 := Trim(Term)
    StringLower, Query1, Query1
    Query2 := StrReplace(Query1, A_Space, "+")

    URLs := Group2String(Groups[Index], Query1, Query2)
    Run, % Browser " " History " " Windows " " URLs
    ExecuteThis()
    Return
}

; Default groups
#z::Paste2Search(1)
#x::Input2Search(1)

; Optional groups
#+z::Paste2Search(2)
#+x::Input2Search(2)
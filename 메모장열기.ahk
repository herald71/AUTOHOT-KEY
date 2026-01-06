#Requires AutoHotkey v2.0

; Win + M (IME 상태 무관하게)
#HotIf GetKeyState("LWin", "P") || GetKeyState("RWin", "P")
*m::
{
    Run "notepad.exe"
}

#HotIf

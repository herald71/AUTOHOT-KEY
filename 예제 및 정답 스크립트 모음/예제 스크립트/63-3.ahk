#include EveryHangul.ahk

hangul := EveryHangul()

F1::
{
	Send("^{a}")
	Sleep(100)
	Send("^{c}")
	Sleep(100)
	MsgBox(hangul.GetFirstConsonant(A_Clipboard))
}

F2::ExitApp
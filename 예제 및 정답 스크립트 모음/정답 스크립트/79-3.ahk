$A::
{
	if (!WinActive("ahk_exe notepad.exe"))
		WinActivate("ahk_exe notepad.exe")
	WinMove(0, 0, , , "A")
	ExitApp
}
$A::
{
	if (!WinActive("ahk_exe notepad.exe"))
	{
		Send("{a}")
		return
	}
	WinMove(0, 0, , , "A")
	ExitApp
}
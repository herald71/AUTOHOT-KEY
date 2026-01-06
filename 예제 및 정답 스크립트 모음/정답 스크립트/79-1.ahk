hwndList := []

F1::
{
	hwndList.Push(WinExist("A"))
}

F2::
{
	result := ""
	Loop hwndList.Length
		result .= hwndList[A_Index] "`n"
	MsgBox(result)
	ExitApp
}
1::
2::
3::
4::
5::
6::
7::
8::
9::
{
	MsgBox(GetGugu(A_ThisHotkey))
}

ESC::ExitApp

GetGugu(dan)
{
	Loop 9
		result .= dan " x " A_Index " = " dan * A_Index "`n"
	return result
}
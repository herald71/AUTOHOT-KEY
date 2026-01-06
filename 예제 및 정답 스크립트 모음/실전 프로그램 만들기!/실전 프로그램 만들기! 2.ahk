MsgBox("프로그램이 시작되었습니다.")

Loop
{
	if (A_Min = 00)
	{
		MsgBox("정각입니다. 물을 마시세요.")
		Sleep(60 * 1000)
	}
	else if (A_Min = 30)
	{
		MsgBox("30분입니다. 운동하세요.")
		Sleep(60 * 1000)
	}
	Sleep(1000)
}

ESC::
{
	if (MsgBox("종료하시겠습니까?",,"YesNo") = "Yes")
	ExitApp
}
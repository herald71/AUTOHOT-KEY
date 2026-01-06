Loop
{
	Loop
	{
		if (A_Hour = 20 && A_Min = 00)
		break
		Sleep(1000)
	}
	Send("{PrintScreen}")
	run("C:\Program Files (x86)\Kakao\KakaoTalk\KakaoTalk.exe")
	Sleep(10000) ;카카오톡이 켜질 때까지 넉넉히 기다리기
	ControlClick("X31 Y120", "카카오톡")
	Sleep(1000)
	ControlSend("^{f}", "EVA_Window2", "카카오톡")
	Sleep(500)
	ControlSetText("채팅방 이름", "Edit2", "카카오톡")
	Sleep(500)
	ControlSend("{Enter}", "EVA_Window2", "카카오톡")
	Sleep(3000) ;채팅창이 켜질 때까지 넉넉히 기다리기
	ControlSend("^{v}", "RICHEDIT50W1", "채팅방 이름") ;채팅방 이름 수정
	Sleep(500)
	ControlSend("{Enter}", "Edit1", "ahk_exe KakaoTalk.exe")
	Sleep(5000)
	ControlSend("{ESC}",, "채팅방 이름") ;채팅방 이름 수정
	ControlSend("{ESC}",, "카카오톡")
	Sleep(1000 * 60)
}

F2::ExitApp
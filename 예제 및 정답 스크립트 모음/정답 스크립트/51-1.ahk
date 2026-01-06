bottles := 5
Loop 5
{
	ControlSend(bottles "병의 맥주가 벽장에 있네, " bottles "병의 맥주라네`n", "Edit1", "ahk_exe notepad.exe")
	bottles--
	if (bottles > 0)
		ControlSend("하나를 내려서 차례로 돌렸네, " bottles "병의 맥주가 벽장에 있네`n`n", "Edit1", "ahk_exe notepad.exe")
}
ControlSend("하나를 내려서 차례로 돌렸네, 더이상 벽장에 맥주가 없네`n`n", "Edit1", "제목 없음 - Windows 메모장")
ControlSend("더 이상 벽장에 맥주가 없네, 맥주는 더 이상 없다네`n가게로 가서 더 사왔네, 99병의 맥주가 벽장에 있네", "Edit1", "ahk_exe notepad.exe")

/* else를 쓰든, continue를 쓰든,기타 여러 방법을 쓰든 보기와 동일한 결과를 보이면 정답입니다.
 * (단, 조건에 쓰인 대로 코드 제한은 15줄 이하, ControlSend를 사용해야함)
 */
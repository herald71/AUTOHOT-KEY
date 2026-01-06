bottles := 5
Loop 5
{
	allText .= bottles "병의 맥주가 벽장에 있네, " bottles "병의 맥주라네`n"
	bottles--
	if (bottles > 0)
		allText .= "하나를 내려서 차례로 돌렸네, " bottles "병의 맥주가 벽장에 있네`n`n"
}
allText .= "하나를 내려서 차례로 돌렸네, 더이상 벽장에 맥주가 없네`n`n"
allText .= "더 이상 벽장에 맥주가 없네, 맥주는 더 이상 없다네`n가게로 가서 더 사왔네, 99병의 맥주가 벽장에 있네"
ControlSetText(allText, "Edit1", "ahk_exe notepad.exe")
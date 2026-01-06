MsgBox("핫키를 눌러주세요.`nF1: ahkv2.pnal.dev, 한글`nF2: 폴더, 한글")

F1::
{
	run("https://ahkv2.pnal.dev")
	run(A_Desktop "\Test.hwpx")
	ExitApp
}

F2::
{
	run(A_Desktop "\TestFolder")
	run(A_Desktop "\Test.hwpx")
	ExitApp
}
; !!!!!!!!!!!!!!!!!!!!!!
;제 PC 환경과 여러분의 PC 환경은 다르므로, 이미지는 스스로 준비하셔야 합니다.
; !!!!!!!!!!!!!!!!!!!!!!
run("https://www.nl.go.kr")
Loop
{
	if (ImageSearch(&vx, &vy, 0, 0, A_ScreenWidth, A_ScreenHeight, "Search.png"))
	break
	Sleep(1000)
}
MouseClick("L", vx + 10, vy + 5)
Send("디지털북스{Enter}")
Loop
{
	if (ImageSearch(&vx, &vy, 0, 0, A_ScreenWidth, A_ScreenHeight, "More.png"))
	break
	Sleep(1000)
}
MouseClick("L", vx + 10, vy + 5)
Loop
{
	if (ImageSearch(&vx, &vy, 0, 0, A_ScreenWidth, A_ScreenHeight, "Select.png"))
	break
	Sleep(1000)
}
MouseClick("L", vx, vy)
ImageSearch(&vx, &vy, 0, 0, A_ScreenWidth, A_ScreenHeight, "Download.png")
MouseClick("L", vx + 10, vy + 5)
ExitApp

ESC::
{
	ExitApp
}
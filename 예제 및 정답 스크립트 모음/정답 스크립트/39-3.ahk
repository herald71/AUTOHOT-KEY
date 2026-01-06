CoordMode("Mouse", "Screen")
posX := 0
posY := 0

F1::
{
	global posX
	global posY
	MouseGetPos(&posX, &posY)
	MsgBox("저장된 좌표: (" posX ", " posY ")")
}

F2::
{
	global posX += 100
	global posY += 100
	MouseMove(posX, posY)
}

F3::
{
	MouseClick("L", posX, posY)
	Send(A_ThisHotkey)
}

ESC::
{
	ExitApp
}
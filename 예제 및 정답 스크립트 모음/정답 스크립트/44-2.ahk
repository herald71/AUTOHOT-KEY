;colorList 전역 변수에 좌표와 색상을 저장하겠습니다.
colorList := ""

CoordMode("Pixel", "Screen")
CoordMode("Mouse", "Screen")

F1::
{
    global colorList
    MouseGetPos(&vx, &vy)
    colorList .= "(" vx ", " vy ") " PixelGetColor(vx, vy) "`n"
}

F2::
{
    MsgBox(colorList)
    ExitApp
}
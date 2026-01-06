CoordMode("Pixel", "Screen")
prevColor := PixelGetColor(A_ScreenWidth // 2, A_ScreenHeight // 2)
Loop
{
    nowColor := PixelGetColor(A_ScreenWidth // 2, A_ScreenHeight // 2)
    if (prevColor != nowColor)
        break
    Sleep(500)
}
MsgBox("화면이 변화했습니다.")
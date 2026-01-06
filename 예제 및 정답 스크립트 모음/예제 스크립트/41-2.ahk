CoordMode("Pixel", "Screen")
Loop
{
    if (ImageSearch(&vx, &vy, 0, 0, A_ScreenWidth, A_ScreenHeight, "Image\2.png"))
        break
    Sleep(1000)
}
MsgBox("찾았습니다! 좌표: (" vx ", " vy ")")
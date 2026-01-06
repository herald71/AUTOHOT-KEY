Run("https://ahkv2.pnal.dev")
CoordMode("Pixel", "Screen")
Loop
{
    if (ImageSearch(&vx, &vy, 0, 0, A_ScreenWidth, A_ScreenHeight, "Image\refresh.png"))
        break
}
MsgBox("웹사이트가 열렸습니다.")
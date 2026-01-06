CoordMode("Pixel", "Screen")
CoordMode("Mouse", "Screen")

F1::
{
    if (ImageSearch(&vx, &vy, 0, 0, A_ScreenWidth, A_ScreenHeight, "Image\1.png"))
        MouseClick("L", vx, vy, 2)
	ExitApp
}
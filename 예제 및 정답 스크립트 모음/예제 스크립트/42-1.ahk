F1::
{
    MouseGetPos(&posX, &posY)
    if (PixelSearch(&vx, &vy, posX, posY, posX + 100, posY + 100, 0x00C896))
        MsgBox("찾았습니다! (" vx ", " vy ")")
}

F2::
{
    ExitApp
}
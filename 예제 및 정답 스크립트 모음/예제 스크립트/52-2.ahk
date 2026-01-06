MsgBox(GetAbs(-2))
MsgBox(GetAbs(2))

GetAbs(originalNumber)
{
    if (originalNumber < 0)
        originalNumber := -originalNumber
    return originalNumber
}
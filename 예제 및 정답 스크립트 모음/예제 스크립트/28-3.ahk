outer := 0
inner := 0

Loop 5
{
    outer++
    Loop 5
    {
        inner++
        MsgBox("바깥쪽 Loop: " outer "회`n안쪽 Loop: " inner "회")
    }
    inner := 0
}
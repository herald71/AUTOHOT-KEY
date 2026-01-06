numbers := "100`n53`n80`n75`n90"
sum := 0
Loop Parse numbers, "`n", "`r"
{
    sum += A_LoopField
}
MsgBox(sum)
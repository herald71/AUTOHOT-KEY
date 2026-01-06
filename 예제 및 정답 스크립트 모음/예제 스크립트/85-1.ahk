numbers := "100, 53, 80, 75, 90"
sum := 0
Loop Parse numbers, ","
{
    sum += A_LoopField
}
MsgBox(sum)
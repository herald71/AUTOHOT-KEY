Loop 10
{
    if (Mod(A_Index, 2) = 0)
    {
        MsgBox(A_Index ": 2의 배수입니다.")
    }
    else if (Mod(A_Index, 3) = 0)
    {
        MsgBox(A_Index ": 3의 배수입니다.")
    }
    else
    {
        MsgBox(A_Index ": 어느 쪽도 아닙니다.")
    }
}
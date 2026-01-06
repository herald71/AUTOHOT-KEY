F1::
{
    dan := A_Sec // 10 + 1 ;현재 초의 10의 자리 + 1을 단으로 한다.
    Loop 9
        result .= dan " x " A_Index " = " dan * A_Index "`n" ;2 x 4 = 8`n 형식으로, .= 연산자를 사용하여 문자열을 이어붙임
    MsgBox("현재 초: " A_Sec "`n`n" result)
}

F2::
{
    ExitApp
}
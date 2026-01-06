ShowMsg("ABC", "DEF")

ShowMsg(string1, string2, string3 := "")
{
    MsgBox("필수 매개변수로 " string1 ", " string2 "가 전달되었습니다.")
    if (string3 != "")
        MsgBox("선택 매개변수도 전달되었습니다: " string3)
    else
        Msgbox("선택 매개변수는 전달되지 않았습니다.")
}
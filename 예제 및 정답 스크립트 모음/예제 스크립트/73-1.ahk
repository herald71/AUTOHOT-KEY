Main := Gui(, "73강 연습")
PopButton := Main.Add("Button", "x30 y30 w200 h50", "클릭")
Main.Show("w260 h110")
PopButton.OnEvent("Click", PopButton_OnClick)
return

PopButton_OnClick(obj, info)
{
    MsgBox("버튼이 클릭되었습니다.")
}
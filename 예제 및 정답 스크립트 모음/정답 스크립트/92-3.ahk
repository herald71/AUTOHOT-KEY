Main := Gui(, "문제 3")
SenderEdit := Main.Add("Edit", "x20 y20 w150 h200")
SendButton := Main.Add("Button", "x180 y19 w40 h22", "확인")
Main.Show("w240 h240")
SendButton.OnEvent("Click", SendButton_OnClick)
return

SendButton_OnClick(obj, info)
{
	MsgBox(RegExReplace(SenderEdit.Text, "[0-9]"))
}
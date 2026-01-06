Main := Gui(, "문제 2")
SenderEdit := Main.Add("Edit", "x20 y20 w150")
SendButton := Main.Add("Button", "x180 y19 w40 h22", "확인")
ItemList := Main.Add("ListBox", "x20 y50 w200")
Main.Show("w240 h110")
SendButton.OnEvent("Click", SendButton_OnClick)
ItemList.OnEvent("DoubleClick", ItemList_OnDoubleClick)
return

SendButton_OnClick(obj, info)
{
	ItemList.Add([SenderEdit.Text])
}

ItemList_OnDoubleClick(obj, info)
{
	MsgBox(ItemList.Text)
}
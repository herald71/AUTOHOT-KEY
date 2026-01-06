Main := Gui(, "문제 1")
HidePassword := Main.Add("CheckBox", "x20 y20", "비밀번호 가리기")
EditReceiver := Main.Add("Edit", "x20 y50 w200")
Main.Show("w240 h90")
HidePassword.OnEvent("Click", HidePassword_OnClick)
return

HidePassword_OnClick(obj, info)
{
	if (obj.Value = 1)
		EditReceiver.Opt("+Password")
	else
		EditReceiver.Opt("-Password")
}
Main := Gui(, "데이터 추출")
personalInfo := Main.Add("Edit", "x10 y10 w320 h100")
name := Main.Add("Button", "x10 y120 w100 h30", "이름")
email := Main.Add("Button", "x120 y120 w100 h30", "이메일")
token := Main.Add("Button", "x230 y120 w100 h30", "고유 번호")
Main.Show("w340 h160")
name.OnEvent("Click", Name_OnClick)
email.OnEvent("Click", Email_OnClick)
token.OnEvent("Click", Token_OnClick)
return

Name_OnClick(obj, info)
{
	A_Clipboard := GetPersonalInfo(2)
}

Email_OnClick(obj, info)
{
	A_Clipboard := GetPersonalInfo(3)
}

Token_OnClick(obj, info)
{
	A_Clipboard := GetPersonalInfo(4)
}

GetPersonalInfo(index)
{
	Loop Parse personalInfo.text, "`n", "`r"
	{
		result .= StrSplit(A_LoopField, " ")[index] "`n"
	}
	return result
}
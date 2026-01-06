Main := Gui(,"Test Program")
LectureLink := Main.Add("Link", "x10 y10", "<a href=`"https://ahkv2.pnal.dev`">프날 오토핫키 v2</a> 강좌 실습 프로그램")
LicenseLink := Main.Add("Link", "x10 y25", "이 프로그램은 <a>MIT 라이선스</a>로 배포됩니다.")
LicenseLink.OnEvent("Click", LicenseLink_OnClick)
TestButton := Main.Add("Button", "x10 y45 w80 h20", "Button")
TestButton.OnEvent("Click", TestButton_OnClick)
TestEdit := Main.Add("Edit", "x100 y46 w190 h19", "Edit")
TestCheckBox := Main.Add("CheckBox", "x15 y80", "CheckBox")
TestCheckBox := Main.Add("CheckBox", "x15 y100", "CheckBox")
TestRadio1 := Main.Add("Radio", "x150 y80 checked", "Radio1")
TestRadio1 := Main.Add("Radio", "x150 y100", "Radio2")
TestRadio1 := Main.Add("Radio", "x150 y120", "Radio3")
TestDDL := Main.Add("DDL", "x15 y120 w80 Choose1", ["List1", "List2", "List3"])
TestListBox := Main.Add("ListBox", "x10 y150", ["List1",  "List2", "List3"])
TestSlider := Main.Add("Slider", "x150 y150", 0)
TestEdit.Focus()
Main.OnEvent("Close", Main_OnClose)
Main.Show("w300 h200")
OnMessage(0x0101, Main_OnKeyUp)
return

TestButton_OnClick(_obj, _info)
{
	MsgBox("버튼이 클릭되었습니다.")
}

LicenseLink_OnClick(_obj, _info, _href)
{
	MsgBox
	(
"The MIT License (MIT)
Copyright (c) 2022 contact@pnal.dev

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the `"Software`"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED `"AS IS`", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE."
	)
}

Main_OnClose(_obj)
{
	ExitApp
}

Main_OnKeyUp(_wParam, _lParam, _msg, _hwnd)
{
	KeyName := GetKeyName("VK" SubStr(Format("0x{:x}", _wParam), 3))
	if (KeyName = "F5" && _hwnd = Main.Hwnd)
		MsgBox("키 신호 감지됨!!")
}
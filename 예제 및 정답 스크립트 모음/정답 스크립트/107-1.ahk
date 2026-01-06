session := ComObject("WinHTTP.WinHTTPRequest.5.1")
session.Open("POST", "https://ahkv2.pnal.dev/playground/login")
session.SetRequestHeader("Content-Type", "application/x-www-form-urlencoded")
session.Send("id=user&pw=1234")
session.Open("GET", "https://ahkv2.pnal.dev/playground/mypage")
session.Send()
RegExMatch(session.ResponseText, "접속한 ID: (.*)<br>", &output)
idText := output[1]
MsgBox(idText)
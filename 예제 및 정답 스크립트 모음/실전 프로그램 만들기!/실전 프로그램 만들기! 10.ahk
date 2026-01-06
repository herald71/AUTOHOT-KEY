driver := ComObject("Selenium.ChromeDriver")
driver.Get("https://ahkv2.pnal.dev/playground/login")
driver.FindElementById("username").SendKeys("user")
driver.SendKeys(driver.Keys.Tab)
driver.SendKeys("1234")
driver.FindElementByXPath("/html/body/main/div/form/input").Click()

Loop
{
	driver.Get("https://ahkv2.pnal.dev/playground/qna")
	rows := driver.FindElementsByTag("tr")
	Loop rows.Count
	{
		row := rows[A_Index]
		innerText := row.Attribute("innerText")
		if (InStr(innerText, "미답변"))
		{
			row.FindElementByTag("a").Click()
			qnaText := driver.FindElementById("content").Attribute("innerText")
			StrReplace(qnaText, "자료",,, &OutputVarCount)
			if (OutputVarCount >= 3)
			{
				driver.FindElementByClass("comment-text").SendKeys("자료는 https://pnal.dev/downloads 에서 다운로드하실 수 있습니다 ^^")
				driver.FindElementByClass("comment-submit").Click()
			}
			break
		}
		Sleep(1000)
	}
	Sleep(10000)
}

ESC::ExitApp
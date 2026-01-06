driver := ComObject("Selenium.ChromeDriver")
driver.Get("https://ahkv2.pnal.dev/playground")
driver.SendKeys(driver.Keys.End)
driver.FindElementByXPath("/html/body/main/article/div/textarea").SendKeys("안녕하세요.")
driver.FindElementByXPath("/html/body/main/article/div/button").Click()
Sleep(5000) ;5초 후 자동으로 프로그램이 종료됩니다.
ExitApp
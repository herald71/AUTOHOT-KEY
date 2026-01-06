Main := Gui("+AlwaysOnTop", "내 런처")
WeatherButton := Main.Add("Button", "x10 y10 w70 h40", "지역 날씨")
FolderButton := Main.Add("Button", "x100 y10 w70 h40", "작업 폴더")
CalcButton := Main.Add("Button", "x190 y10 w70 h40", "계산기")
Main.Add("Text", "x10 y63 w40 h20", "1달러=")
ExchangeRate := Main.Add("Edit", "x50 y60 w35 h20", "1200")
Main.Add("Text", "x90 y63 w45 h20", "원일 때, ")
ExchangeValue := Main.Add("Edit", "x145 y60 w35 h20", "1")
ExchangeResult := Main.Add("Text", "x185 y63 w100 h20", "달러는 1200원")
SearchText := Main.Add("Edit", "x10 y100 w200 h20")
SearchButton := Main.Add("Button", "x220 y99 w40 h22", "검색")
Main.Show("w280 h150")

WeatherButton.OnEvent("Click", WeatherButton_OnClick)
FolderButton.OnEvent("Click", FolderButton_OnClick)
CalcButton.OnEvent("Click", CalcButton_OnClick)
ExchangeValue.OnEvent("Change", ExchangeValue_OnChange)
SearchButton.OnEvent("Click", SearchButton_OnClick)
return

WeatherButton_OnClick(obj, info)
{
	run("https://weather.naver.com/today/09215109")
}

FolderButton_OnClick(obj, info)
{
	run(A_Desktop "\내 폴더 이름") ;폴더 이름 수정
}

CalcButton_OnClick(obj, info)
{
	run("calc.exe")
}

ExchangeValue_OnChange(obj, info)
{
	if (IsNumber(ExchangeValue.value))
		ExchangeResult.value := "달러는 " ExchangeValue.value * ExchangeRate.value "원"
}

SearchButton_OnClick(obj, info)
{
	run("https://search.naver.com/search.naver?where=nexearch&sm=top_hty&fbm=0&ie=utf8&query=" SearchText.text)
}
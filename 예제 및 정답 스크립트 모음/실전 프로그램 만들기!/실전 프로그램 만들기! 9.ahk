;!!!!!!!!!!!!!!!
;같은 경로에 TestFolder 폴더가 있어야 합니다.
;!!!!!!!!!!!!!!!

session := ComObject("WinHTTP.WinHTTPRequest.5.1")
session.Open("GET", "https://www.yes24.com/Product/Search?domain=ALL&query=디지털북스")
session.Send()
originalText := session.ResponseText
RegExMatch(originalText, "ms)<section id=`"goodsListWrap`"(.*?)</section>", &cutText)
A_Clipboard := originalText := cutText[1]

bookList := []
Loop
{
	pos := RegExMatch(originalText, "class=`"lazy`" data-original=`"(.*?)`"", &subPat)
	if (!pos)
		break
	bookList.Push(subPat[1])
	originalText := SubStr(originalText, pos + 1)
}

Loop bookList.Length
{
	Download(StrReplace(bookList[A_Index], "/L", "/XL"), "TestFolder\" A_Index ".jpeg")
	Sleep(3000)
}
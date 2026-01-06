GetSource()
{
	requestObj := ComObject("WinHttp.WinHttpRequest.5.1")
	requestObj.Open("GET", "https://ahkv2.pnal.dev/playground", true)
	requestObj.Send()
	requestObj.WaitForResponse()
	result := requestObj.ResponseText
	return result
}
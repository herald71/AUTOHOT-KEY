html := "<html><head><\head><body><table>Me!</table></body></html>"
subPat := {}
RegExMatch(html, "<table>(.*)</table>", &subPat)
MsgBox(subPat[1])

;RegExReplace를 사용시, 아래와 같은 패턴을 사용할 수도 있다.
MsgBox(RegExReplace(html, "(.*)<table>|</table>(.*)"))
haystack := "서울-00차-0000"
subPat := {}
stringPos := RegExMatch(haystack, "-(.*)-", &subPat)
MsgBox("위치: " subPat.Pos[1] "`n문자열: " subPat[1])
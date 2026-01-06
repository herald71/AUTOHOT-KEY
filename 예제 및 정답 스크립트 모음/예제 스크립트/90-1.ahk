haystack := "서울-00차-0000"
replacedString := RegExReplace(haystack, "[^0-9]")
MsgBox(replacedString)
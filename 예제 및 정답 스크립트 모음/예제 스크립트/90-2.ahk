haystack := "contact@xxxxxxx.xxxx"
replacedString := RegExReplace(haystack, "@(.*)", "@example.org")
MsgBox(replacedString)
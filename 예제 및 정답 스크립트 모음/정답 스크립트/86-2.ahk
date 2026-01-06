context := "2024-01-01 12:20:30"
splitedText := StrSplit(context, ["-", ":", " "])
Loop splitedText.Length
	result .= "[" A_Index "]" splitedText[A_Index] " "
MsgBox(result)
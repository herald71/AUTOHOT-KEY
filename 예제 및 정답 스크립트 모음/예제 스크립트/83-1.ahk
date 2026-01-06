context := "
(
도산 안창호
백범 김구
추사 김정희
율곡 이이
)"

splitedText := StrSplit(context, "`n", "`r")
Loop splitedText.Length
    mergedText .= SubStr(splitedText[A_Index], 4) "`n"
MsgBox(mergedText)
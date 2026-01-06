context := "모든 국민은 평생에 걸쳐 학습하고`n능력과 적성에 따라 교육받을 권리를 가진다"
splitedText := StrSplit(context, "`n", "`r")
Loop splitedText.Length
    MsgBox(splitedText[A_Index])
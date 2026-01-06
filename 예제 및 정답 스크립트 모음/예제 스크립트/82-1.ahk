context := "국가는 평생 교육을 진흥하여야 한다!"
splitedText := StrSplit(context, " ")
Loop splitedText.Length
    MsgBox(splitedText[A_Index])
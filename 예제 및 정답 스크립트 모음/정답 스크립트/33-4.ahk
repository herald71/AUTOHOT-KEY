if (MsgBox("7단?",,"YN") = "YES")
    dan := 7
else if (MsgBox("8단?",,"YN") = "YES")
    dan := 8
else if (MsgBox("9단?",,"YN") = "YES")
    dan := 9
else
    ExitApp

Loop 9
    result .= dan " x " A_Index " = " dan * A_Index "`n"
MsgBox(result)
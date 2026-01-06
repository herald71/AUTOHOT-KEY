doubleNumbers := []
Loop 50
    doubleNumbers.Push(A_Index * 2)

Loop doubleNumbers.Length
    result .= "[" A_Index "]" doubleNumbers[A_Index] "`t"
MsgBox(result)
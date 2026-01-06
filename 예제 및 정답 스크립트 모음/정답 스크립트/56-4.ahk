a := 10
b := 20
Swap(&a, &b)
MsgBox("a의 값: " a ", b의 값: " b)

Swap(&a, &b)
{
	temp := a
	a := b
	b := temp
}
/* 테스트 스크립트
math := MyMath()
MsgBox(math.Exponent(2, 3))
MsgBox(math.Exponent10(2, 4))
MsgBox(math.GetArea(2))
*/

class MyMath
{
	PI := 3.14

	Exponent(n, m)
	{
		result := n
		Loop m-1
			result *= n
		return result
	}

	Exponent10(n, m)
	{
		return this.Exponent(n, m) / 10
	}

	GetArea(n)
	{
		return n * n * this.PI
	}
}
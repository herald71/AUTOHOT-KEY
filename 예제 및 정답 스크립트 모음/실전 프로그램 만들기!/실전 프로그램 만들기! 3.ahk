F1::
{
	Loop 69
	{
		run("https://ahkv2.pnal.dev/" A_Index,,"Max") ;웹페이지 실행
		Sleep(3000) ;웹페이지가 로딩 될 때까지 기다림
		MouseClick("L", 552, 354, , ,"D")
		Send("{End}") ;웹페이지 최하단으로 스크롤
		Sleep(1000) ;웹페이지가 스크롤 될 때까지 기다림
		MouseClick("L", 1387, 790, , ,"U")
		Send("^{c}") ;복사
		Sleep(1000)

		Send("!{Tab}") ;'한글'로 돌아가기'
		Sleep(1000)
		Send("^{v}") ;붙여넣기
		Sleep(1000)
		Send("{Enter}") ;붙여넣기 옵션 선택
		Sleep(1000)
		Send("^{Enter}") ;쪽갈이
		Sleep(1000)
	}
}

ESC::
{
	ExitApp
}
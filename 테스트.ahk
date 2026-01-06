#Requires AutoHotkey v2.0

#m::  ; Win + M
{
    Run "notepad.exe", , "Max"  ; 메모장을 최대화하여 실행
    WinWaitActive "ahk_class Notepad"
    Sleep 300  ; 안정성 확보

    ; 텍스트 입력
    SendText "- 아 래 -`n`n"
    SendText "1. 상품명 :"  ; 여기까지 입력 후 ↓ 방향키로 아래줄 이동
    Send "`n"  ; 줄바꿈
    ; 이제 커서가 여기 위치

    SendText "`n2. 단가 :`n`n"
    SendText "3. MOQ :`n`n"
    SendText "4. 상품소싱처 :`n`n"
    SendText "5. 메인 검색어 :`n`n"
    SendText "6. 기타사항 :"

    ; 커서 다시 "1. 상품명 :" 다음 줄로 이동
    Send "^{Home}"         ; 문서 맨 앞으로 이동
    Send "{Down 2}"        ; 두 줄 아래 (1. 상품명 : 다음 줄로)
}

#Requires AutoHotkey v2.0  ; AutoHotkey v2.0 이상 버전 필요

/*
프로그램명: 자동화 핫키 스크립트
작성자: 신진우 (herald.shin@gmail.com)
작성일: 2025-04-15

주요 기능:
- 자주 사용하는 주소 자동 입력 (4개 주소 저장)
- 메모장, 엑셀, 파워포인트 등 자주 사용하는 프로그램 단축키 실행
- 자동 마우스 클릭 기능
- 날짜 자동 입력
- 주요 웹사이트(YouTube, ChatGPT, 쿠팡 등) 바로가기
- 상품 소싱용 메모장 템플릿 자동 생성

업데이트 내역:
- 2025-04-15: 최초 작성
- 2025-04-28: 주석 보완 및 오류 수정, Figma 실행 기능 추가

[단축키 목록]
1. 주소 자동 입력 (핫스트링)
   - addr1: 경기도 하남시 미사강변대로 95, 미사강변센트럴자이 102동102호
   - addr2: 서울시 동대문구 전농로 22, 엠제이빌딩 5층 (주)썸유
   - addr3: 경기도 포천시 소홀읍 호국로 302-20 5동
   - addr4: 경기도 하남시 조정대로 45, F8층 821호(풍산동,미사센텀비즈)
   - tod: 오늘 날짜 자동 입력 (yyyy-MM-dd 형식)

2. 프로그램 실행 단축키
   - Ctrl+Alt+N: 메모장 실행
   - Ctrl+Alt+E: 엑셀 실행
   - Ctrl+Alt+C: Windows 계산기 실행
   - Ctrl+Alt+P: 파워포인트 실행
   - Ctrl+Alt+J: Jupyter Notebook 실행 (Anaconda 환경)
   - Win+1: Notion 실행
   - Win+2: Cursor AI 실행
   - Win+C: AI질문답변2 실행
   - Win+I: 거래명세서확인 실행
   - Win+M: 상품소싱 메모장 템플릿 생성
   - Win+4: Figma 실행

3. 웹사이트 바로가기
   - Ctrl+Alt+Y: YouTube 열기
   - Ctrl+Alt+G: ChatGPT 열기
   - Ctrl+Alt+S: 쿠팡서플라이어 허브 로그인
   - Ctrl+Alt+W: 쿠팡윙 로그인
   - Ctrl+Alt+M: 메이크샵 로그인
   - Ctrl+Alt+V: 네이버 스마트스토어 로그인
   - Win+O: 올라 로그인
   - Win+T: EcountERP 로그인

4. 유틸리티 단축키
   - F8: 마우스 자동 클릭 (키를 누르고 있는 동안 지속 클릭)
   - Ctrl+Alt+X: 현재 활성화된 창 닫기
*/

; ===== 전역 설정 변수 =====
; 마우스 자동 클릭 간격 설정 (밀리초 단위)
; 값이 작을수록 클릭 속도가 빨라지며, 시스템 부하가 증가할 수 있습니다
ClickInterval := 100

; 기본 웹 브라우저 지정
; 사용 중인 브라우저에 맞게 변경 가능: "chrome.exe", "msedge.exe", "firefox.exe" 등
DefaultBrowser := "chrome.exe"

; ===== 1. 자주 사용하는 주소 텍스트 자동 입력 =====
; 핫스트링 기능을 사용하여 특정 텍스트 입력 시 자동으로 주소로 변환됩니다
; 사용법: "addr1"을 입력하고 스페이스바나 엔터를 누르면 자동으로 주소가 입력됩니다

; addr1 입력 시 자동으로 주소 입력
::addr1::경기도 하남시 미사강변대로 95, 미사강변센트럴자이 102동102호

; addr2 입력 시 자동으로 주소 입력
::addr2::서울시 동대문구 전농로 22, 엠제이빌딩 5층 (주)썸유

; addr3 입력 시 자동으로 주소 입력
::addr3::경기도 포천시 소홀읍 호국로 302-20 5동

; addr4 입력 시 자동으로 주소 입력
::addr4::경기도 하남시 조정대로 45, F8층 821호(풍산동,미사센텀비즈)

; ===== 2. 메모장 실행 단축키 =====
; Ctrl + Alt + N 키를 누르면 Windows 메모장을 실행합니다
^!n::Run "notepad.exe"

; ===== 3. 오늘 날짜 자동 입력 =====
; "tod"를 입력하고 스페이스바나 엔터를 누르면 현재 날짜가 yyyy-MM-dd 형식으로 자동 입력됩니다
; 예: 2025-04-28
::tod::
{
    Send FormatTime(A_Now, "yyyy-MM-dd")  ; 현재 날짜를 yyyy-MM-dd 형식으로 전송
}


; ===== 4. 마우스 자동 클릭 기능 =====
; F8 키를 누르고 있으면 마우스 커서 위치에서 자동으로 클릭이 반복됩니다
; F8 키를 떼면 클릭이 중지됩니다
; 주의: 클릭 간격은 ClickInterval 변수로 조절 가능하며, 기본값은 100ms입니다
F8::
{
    Loop  ; 무한 반복
    {
        Click  ; 현재 마우스 커서 위치에서 클릭
        Sleep ClickInterval  ; 설정된 간격만큼 대기 (기본 100ms)
        if !GetKeyState("F8", "P")  ; F8 키가 눌려있지 않으면
            break  ; 반복 종료
    }
}

; ===== 5. 현재 활성화된 창 종료 =====
; Ctrl + Alt + X 키를 누르면 현재 포커스된 창이 닫힙니다
; 주의: 저장하지 않은 작업이 있으면 데이터 손실이 발생할 수 있습니다
^!x::WinClose "A"  ; "A"는 현재 활성화된(Active) 창을 의미



; ===== 6. 엑셀 실행 =====
; Ctrl + Alt + E 키를 누르면 Microsoft Excel을 실행합니다
^!e::
{
    Run "excel.exe"  ; Excel 실행
}

; ===== 7. Windows 계산기 실행 =====
; Ctrl + Alt + C 키를 누르면 Windows 기본 계산기를 실행합니다
^!c::
{
    Run "calc.exe"  ; Windows 계산기 실행
}

; ===== 8. YouTube 웹사이트 실행 =====
; Ctrl + Alt + Y 키를 누르면 기본 브라우저로 YouTube를 엽니다
^!y::
{
    Run DefaultBrowser . " https://www.youtube.com"  ; 기본 브라우저로 YouTube 실행
}

; ===== 9. ChatGPT 웹사이트 실행 =====
; Ctrl + Alt + G 키를 누르면 기본 브라우저로 ChatGPT를 엽니다
^!g::
{
    Run DefaultBrowser . " https://chat.openai.com"  ; 기본 브라우저로 ChatGPT 실행
}

; ===== 10. 파워포인트 실행 =====
; Ctrl + Alt + P 키를 누르면 Microsoft PowerPoint를 실행합니다
^!p::
{
    Run "POWERPNT.EXE"  ; PowerPoint 실행
}

; ===== 11. Jupyter Notebook 실행 =====
; Ctrl + Alt + J 키를 누르면 Anaconda 환경의 Jupyter Notebook을 실행합니다
; 주의: Anaconda가 C:\ProgramData\anaconda3에 설치되어 있어야 합니다
^!j::  ; Ctrl + Alt + J
{
    ; Anaconda 환경에서 Jupyter Notebook을 실행하는 명령어
    cmd := 'cmd.exe /c "C:\ProgramData\anaconda3\python.exe C:\ProgramData\anaconda3\cwp.py C:\ProgramData\anaconda3 C:\ProgramData\anaconda3\python.exe C:\ProgramData\anaconda3\Scripts\jupyter-notebook-script.py %USERPROFILE%/"'
    Run cmd, , "Hide"  ; 명령 프롬프트 창을 숨기고 실행
}


; ===== 12. 쿠팡서플라이어 허브 웹사이트 실행 =====
; Ctrl + Alt + S 키를 누르면 기본 브라우저로 쿠팡서플라이어 허브 로그인 페이지를 엽니다
^!s::
{
    ; 쿠팡서플라이어 허브 로그인 URL
    Run DefaultBrowser . " https://xauth.coupang.com/auth/realms/seller/protocol/openid-connect/auth?response_type=code&client_id=supplier-hub&scope=openid&state=6SRO8v7rWaMD49gx1L23L9v4veYFNv3kd9N97BvZDlM%3D&redirect_uri=https://supplier.coupang.com/login/oauth2/code/keycloak&nonce=6gdVbNSHKxR1lsnjhIrrrs9CwBFzlDfmvpz64g-vwxM"
}



; ===== 13. 쿠팡윙 로그인 웹사이트 실행 =====
; Ctrl + Alt + W 키를 누르면 기본 브라우저로 쿠팡윙 로그인 페이지를 엽니다
^!w::
{
    ; 쿠팡윙 로그인 URL
    Run DefaultBrowser . " https://xauth.coupang.com/auth/realms/seller/protocol/openid-connect/auth?response_type=code&client_id=wing&redirect_uri=https%3A%2F%2Fwing.coupang.com%2Fsso%2Flogin?returnUrl%3Dhttp%253A%252F%252Fwing.coupang.com%252Ftenants%252Fseller-web%252Fgateway&state=7ef2661b-852f-4dde-bbd7-5c76cae4f464&login=true&ui_locales=ko-KR&scope=openid"
}


; ===== 14. 메이크샵 로그인 실행 =====
; Ctrl + Alt + M 키를 누르면 기본 브라우저로 메이크샵 로그인 페이지를 엽니다
^!m::
{
    Run DefaultBrowser . " https://www.makeshop.co.kr/newmakeshop/home/login.html"  ; 메이크샵 로그인 페이지 실행
}


; ===== 15. 네이버 스마트스토어 로그인 실행 =====
; Ctrl + Alt + V 키를 누르면 기본 브라우저로 네이버 스마트스토어 로그인 페이지를 엽니다
^!v::
{
    Run DefaultBrowser . " https://accounts.commerce.naver.com/login?url=https%3A%2F%2Fsell.smartstore.naver.com%2F%23%2Flogin-callback"  ; 네이버 스마트스토어 로그인 페이지 실행
}

; ===== 16. 상품소싱 메모장 템플릿 생성 =====
; Windows + M 키를 누르면 메모장을 최대화하여 실행하고 상품소싱용 템플릿을 자동으로 입력합니다
#m::  ; Win + M
{
    Run "notepad.exe", , "Max"  ; 메모장을 최대화하여 실행
    WinWaitActive "ahk_class Notepad"  ; 메모장 창이 활성화될 때까지 대기
    Sleep 200  ; 잠시 대기 (안정성 확보)

    ; 상품소싱용 템플릿 자동 입력
    SendText "- 아 래 -`n`n"
    SendText "1. 로드한 이미지의 외국어 제품 정보를 자연스럽고 이해하기 쉽게 한국어로 번역하며, 한국어 텍스트인 경우 핵심을 요약합니다. 창작이나 추론은 하지 않습니다.`n`n"
    SendText "2. 기본 쿠팡용 상세페이지 기획안 작성 해주세요`n`n"
    SendText "3. 와디즈 스타일 쿠팡용 상세페이지 기획안 작성 해주세요`n`n"
    SendText "4. SEO 최적화 상품명 제안 (쿠팡용 / 스마트스토어용 각각) 해주세요`n`n"
    SendText "5. 연관 검색어 제안 해주세요"
}

; ===== 17. AI질문답변2 실행 =====
; Windows + C 키를 누르면 AI질문답변2 AutoHotkey 스크립트를 실행합니다
; 주의: 파일 경로가 변경되면 이 경로도 수정해야 합니다
#c::
{
    Run "G:\내 드라이브\Cursor\오토핫키\AI질문답변2.ahk"  ; AI질문답변2 스크립트 실행
    return
}

; ===== 18. 거래명세서확인 실행 =====
; Windows + I 키를 누르면 쿠팡 거래명세서 확인 프로그램을 실행합니다
; 주의: 파일 경로가 변경되면 이 경로도 수정해야 합니다
#i::
{
    Run "C:\Users\owner\Documents\python\dist\쿠팡거래명세서확인.exe"  ; 거래명세서확인 프로그램 실행
    return
}

; ===== 19. 올라 로그인 실행 =====
; Windows + O 키를 누르면 기본 브라우저로 올라(Allra) 로그인 페이지를 엽니다
#o::
{
    Run DefaultBrowser . " https://www.allra.co.kr"  ; 올라 로그인 페이지 실행
}

; ===== 20. EcountERP 실행 =====
; Windows + T 키를 누르면 기본 브라우저로 EcountERP 로그인 페이지를 엽니다
#t::
{
    Run DefaultBrowser . " https://login.ecount.com/Login/"  ; EcountERP 로그인 페이지 실행
}

; ===== 21. Notion 실행 =====
; Windows + 1 키를 누르면 Notion 애플리케이션을 실행합니다
; 주의: Notion이 설치되어 있고 PATH에 등록되어 있어야 합니다
#1::
{
    Run "notion.exe"  ; Notion 실행
    return
}

; ===== 22. Cursor AI 실행 =====
; Windows + 2 키를 누르면 Cursor AI 코드 에디터를 실행합니다
; 주의: Cursor가 설치되어 있고 PATH에 등록되어 있어야 합니다
#2::
{
    Run "Cursor.exe"  ; Cursor AI 실행
    return
}

; ===== 23. Figma 실행 =====
; Windows + 4 키를 누르면 Figma 디자인 툴을 실행합니다
; 주의: Figma가 설치되어 있고 PATH에 등록되어 있어야 합니다
#4::
{
    Run "Figma.exe"  ; Figma 실행
    return
}






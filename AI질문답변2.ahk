#Requires AutoHotkey v2.0

;====================================================================================
; 프로그램명: ChatGPT 질문답변 프로그램 (선택 텍스트 자동 복사 버전)
; 버전: 2.0
; 작성일: 2025-04-27
; 작성자: 신진우    
;====================================================================================
;
; [프로그램 설명]
; - ChatGPT API를 사용하여 질문을 하고 답변을 받을 수 있는 간단한 GUI 프로그램입니다.
; - GPT-4o 모델을 사용하여 더 정확하고 상세한 응답을 생성합니다.
; - 프로그램 실행 시 현재 선택된 텍스트가 자동으로 질문란에 복사됩니다.
;
; [사용 방법]
; 1. 프로그램 실행 전 OpenAI API 키를 환경 변수에 설정해야 합니다.
;    환경 변수명: OPENAI_API_KEY
; 2. 텍스트를 선택한 상태에서 프로그램을 실행하면 선택된 텍스트가 자동으로 질문란에 복사됩니다.
; 3. '질문하기' 버튼을 클릭하면 ChatGPT로부터 답변을 받습니다.
; 4. 답변을 복사하려면 '답변 복사' 버튼을 클릭하세요.
;
; [주의사항]
; - API 키는 반드시 환경 변수에 설정해야 합니다.
; - 인터넷 연결이 필요합니다.
; - API 사용량에 따라 비용이 발생할 수 있습니다.
;====================================================================================

#SingleInstance Force
#Warn
SendMode "Input"
SetWorkingDir A_ScriptDir

; 환경 변수에서 API 키 읽기
apiKey := EnvGet("OPENAI_API_KEY")
if (!apiKey) {
    MsgBox "환경 변수 'OPENAI_API_KEY'가 설정되지 않았습니다.`n`n환경 변수를 설정하는 방법:`n1. 시스템 환경 변수 설정 창을 엽니다.`n2. 새 환경 변수를 추가합니다.`n3. 변수 이름: OPENAI_API_KEY`n4. 변수 값: OpenAI API 키`n`nhttps://platform.openai.com/account/api-keys 에서 API 키를 생성할 수 있습니다."
    ExitApp
}

; 현재 선택된 텍스트 가져오기
selectedText := ""
try {
    ; 클립보드 내용 백업
    oldClipboard := A_Clipboard
    A_Clipboard := ""
    
    ; Ctrl+C 시뮬레이션
    Send "^c"
    Sleep 100
    
    ; 선택된 텍스트 가져오기
    selectedText := A_Clipboard
    
    ; 클립보드 복원
    A_Clipboard := oldClipboard
} catch as e {
    MsgBox "선택된 텍스트를 가져오는 중 오류가 발생했습니다: " e.Message
}

; 대화 기록을 저장할 배열
messages := []

; GUI 생성
MyGui := Gui("+Resize", "ChatGPT 질문답변")
MyGui.SetFont("s10", "Malgun Gothic")
MyGui.BackColor := "FFFFFF"  ; 배경색 흰색으로 설정

; 여백 설정
margin := 10

; 버튼 색상 정의
chatGPTColor := "98DBC6"  ; ChatGPT 계열 버튼 색상 (파스텔 민트)
claudeColor := "E6C0E9"   ; Claude 계열 버튼 색상 (파스텔 퍼플)
perplexityColor := "B5D3FF"  ; Perplexity 계열 버튼 색상 (파스텔 블루)
defaultBtnColor := "F0F0F0"  ; 기본 버튼 색상 (연한 회색)

; 컨트롤 추가
questionText := MyGui.Add("Text", "x" margin " y" margin, "질문:")
questionText.SetFont("bold")
questionEdit := MyGui.Add("Edit", "x" margin " y+5 w680 r3 vQuestion", selectedText)

; 핫키 설정
MyGui.OnEvent("Close", (*) => ExitApp())
MyGui.OnEvent("Escape", (*) => ExitApp())

; 엔터키와 시프트+엔터키 처리를 위한 핫키 추가
#HotIf WinActive("ChatGPT 질문답변")
Enter::
{
    if (!GetKeyState("Shift", "P")) {
        AskGPT()
        return
    }
    Send "{Enter}"
}
+Enter::Send "{Enter}"
#HotIf

; 왼쪽 버튼 그룹 (주요 기능)
askButton := MyGui.Add("Button", "x" margin " y+10 w120 h30 Default Background" defaultBtnColor, "질문하기")
askButton.OnEvent("Click", AskGPT)

resetButton := MyGui.Add("Button", "x" margin " y+5 w120 h30 Background" defaultBtnColor, "대화 초기화")
resetButton.OnEvent("Click", ResetConversation)

; 오른쪽 버튼 그룹 (AI 서비스)
chatGPTButton := MyGui.Add("Button", "x150 yp-35 w160 h30 Background" chatGPTColor, "ChatGPT로 질문보내기")
chatGPTButton.OnEvent("Click", OpenChatGPT)

claudeButton := MyGui.Add("Button", "x+10 w160 h30 Background" claudeColor, "Claude로 질문보내기")
claudeButton.OnEvent("Click", OpenClaude)

perplexityButton := MyGui.Add("Button", "x+10 w160 h30 Background" perplexityColor, "Perplexity로 질문")
perplexityButton.OnEvent("Click", OpenPerplexity)

; 답변 섹션 (여백 추가)
answerText := MyGui.Add("Text", "x" margin " y+45", "답변:")
answerText.SetFont("bold")
answerEdit := MyGui.Add("Edit", "x" margin " y+5 w680 r10 vAnswer ReadOnly")

; 답변 관련 버튼 그룹
copyBtn := MyGui.Add("Button", "x" margin " y+10 w120 h30 Background" defaultBtnColor, "답변 복사")
copyBtn.OnEvent("Click", CopyAnswer)

sendAnswerBtn := MyGui.Add("Button", "x150 yp w160 h30 Background" chatGPTColor, "ChatGPT로 답변보내기")
sendAnswerBtn.OnEvent("Click", SendAnswerToChatGPT)

sendAnswerClaudeBtn := MyGui.Add("Button", "x+10 w160 h30 Background" claudeColor, "Claude로 답변보내기")
sendAnswerClaudeBtn.OnEvent("Click", SendAnswerToClaude)

sendAnswerPerplexityBtn := MyGui.Add("Button", "x+10 w160 h30 Background" perplexityColor, "Perplexity로 답변")
sendAnswerPerplexityBtn.OnEvent("Click", SendAnswerToPerplexity)

; 프로그램 종료 버튼
exitBtn := MyGui.Add("Button", "x" margin " y+10 w120 h30 Background" defaultBtnColor, "프로그램 종료")
exitBtn.OnEvent("Click", ExitProgram)

; 마진 추가
MyGui.MarginX := margin
MyGui.MarginY := margin

; GUI 표시
MyGui.Show()

; JSON 클래스 정의
class JSON {
    static stringify(obj) {
        if IsObject(obj) {
            if obj is Array {
                s := "["
                for value in obj {
                    s .= this.stringify(value) ","
                }
                return RTrim(s, ",") "]"
            } else {
                s := "{"
                for key, value in obj.OwnProps() {
                    s .= '"' key '":' this.stringify(value) ","
                }
                return RTrim(s, ",") "}"
            }
        }
        else if obj is Number
            return obj
        else {
            str := String(obj)
            str := StrReplace(str, "\", "\\")
            str := StrReplace(str, '"', '\"')
            str := StrReplace(str, "`n", "\n")
            str := StrReplace(str, "`r", "\r")
            str := StrReplace(str, "`t", "\t")
            return '"' str '"'
        }
    }
}

; 대기 메시지 창을 위한 전역 변수
global waitingGui := ""

; GPT에 질문하고 답변 받는 함수
AskGPT(*) {
    ; 질문 텍스트 가져오기
    question := questionEdit.Value
    if (question = "") {
        MsgBox "질문을 입력해주세요."
        return
    }

    ; 대기 메시지 창 표시
    ShowWaitingMessage()

    ; HTTP 요청 준비
    url := "https://api.openai.com/v1/chat/completions"
    
    ; 질문 텍스트 전처리
    escapedQuestion := question
    ; 줄바꿈 처리
    escapedQuestion := StrReplace(escapedQuestion, "`r`n", "\n")
    escapedQuestion := StrReplace(escapedQuestion, "`n", "\n")
    ; 특수문자 처리
    escapedQuestion := StrReplace(escapedQuestion, "\", "\\")
    escapedQuestion := StrReplace(escapedQuestion, '`"', '\`"')
    escapedQuestion := StrReplace(escapedQuestion, "`t", "\t")
    
    ; 대화 기록에 새로운 질문 추가
    messages.Push({role: "user", content: escapedQuestion})
    
    ; 요청 데이터 준비
    requestObj := {
        model: "gpt-4o-mini",
        messages: messages
    }
    postData := JSON.stringify(requestObj)

    ; HTTP 요청 보내기
    try {
        ; WinHttpRequest 대신 MSXML2.XMLHTTP 사용
        http := ComObject("MSXML2.XMLHTTP.6.0")
        http.Open("POST", url, false)  ; 동기 요청으로 변경
        http.SetRequestHeader("Content-Type", "application/json; charset=utf-8")
        http.SetRequestHeader("Authorization", "Bearer " apiKey)
        http.Send(postData)
        
        ; 응답 상태 코드 확인
        if (http.Status != 200) {
            HideWaitingMessage()
            MsgBox "API 오류가 발생했습니다. 상태 코드: " http.Status "`n`n응답: " http.ResponseText
            return
        }
        
        ; 응답 처리
        try {
            response := http.ResponseText
            
            ; 응답에서 content 직접 추출
            pattern := '"content":\h*"((?:\\[\x00-\x7F]|[^"\\])*)"'
            if RegExMatch(response, pattern, &match) {
                answer := match[1]
                
                ; 유니코드 이스케이프 시퀀스 처리
                while RegExMatch(answer, "\\u([0-9a-fA-F]{4})", &unicode) {
                    unicodeChar := Chr("0x" unicode[1])
                    answer := StrReplace(answer, unicode[0], unicodeChar)
                }
                
                ; 기타 이스케이프 문자 처리
                answer := StrReplace(answer, "\n", "`n")
                answer := StrReplace(answer, "\r", "`r")
                answer := StrReplace(answer, "\t", "`t")
                answer := StrReplace(answer, '\"', '"')
                answer := StrReplace(answer, "\\", "\")
                
                ; 1000자로 제한
                if (StrLen(answer) > 1000) {
                    answer := SubStr(answer, 1, 1000) "`n`n[답변이 1000자를 초과하여 일부가 생략되었습니다.]"
                }
                
                ; 답변 표시
                answerEdit.Value := answer
                
                ; 대화 기록에 답변 추가
                messages.Push({role: "assistant", content: answer})
                
                ; 대기 메시지 창 닫기
                HideWaitingMessage()
            } else {
                HideWaitingMessage()
                MsgBox "응답 형식이 올바르지 않습니다.`n`n응답: " response
            }
        } catch as err1 {
            HideWaitingMessage()
            MsgBox "응답 처리 중 오류가 발생했습니다: " err1.Message "`n`n응답: " http.ResponseText
        }
    } catch as err2 {
        HideWaitingMessage()
        MsgBox "API 요청 중 오류가 발생했습니다: " err2.Message
    }
}

; 대기 메시지 창 표시 함수
ShowWaitingMessage() {
    global waitingGui
    waitingGui := Gui("+Owner" MyGui.Hwnd, "답변 대기 중...")
    waitingGui.SetFont("s12", "Malgun Gothic")
    waitingGui.Add("Text", "w300 Center", "답변을 생성하는 중입니다.`n잠시만 기다려주세요...")
    waitingGui.Show("AutoSize Center")
}

; 대기 메시지 창 닫기 함수
HideWaitingMessage() {
    global waitingGui
    if (waitingGui) {
        waitingGui.Destroy()
        waitingGui := ""
    }
}

; 답변 복사 함수
CopyAnswer(*) {
    A_Clipboard := answerEdit.Value
    MsgBox "답변이 클립보드에 복사되었습니다."
}

; ChatGPT 웹사이트 열기 함수
OpenChatGPT(*) {
    ; 현재 질문 내용 가져오기
    question := questionEdit.Value
    
    ; 클립보드에 질문 내용 복사
    A_Clipboard := question
    
    ; ChatGPT 웹사이트 열기
    Run "https://chat.openai.com/"
    
    ; 웹사이트가 로드될 때까지 대기
    Sleep 3000
    
    ; Ctrl+V로 질문 내용 붙여넣기
    Send "^v"
    
    ; Enter 키 누르기 (선택사항 - 자동으로 전송하려면 주석 해제)
    ; Send "{Enter}"
}

; Claude로 질문 보내기 함수
OpenClaude(*) {
    ; 현재 질문 내용 가져오기
    question := questionEdit.Value
    
    ; 클립보드에 질문 내용 복사
    A_Clipboard := question
    
    ; Claude 웹사이트 열기
    Run "https://claude.ai/new"
    
    ; 웹사이트가 로드될 때까지 대기
    Sleep 3000
    
    ; Ctrl+V로 질문 내용 붙여넣기
    Send "^v"
}

; Perplexity로 질문 보내기 함수
OpenPerplexity(*) {
    ; 현재 질문 내용 가져오기
    question := questionEdit.Value
    
    ; 클립보드에 질문 내용 복사
    A_Clipboard := question
    
    ; Perplexity 웹사이트 열기
    Run "https://www.perplexity.ai/"
    
    ; 웹사이트가 로드될 때까지 대기
    Sleep 3000
    
    ; Ctrl+V로 질문 내용 붙여넣기
    Send "^v"
}

; ChatGPT로 답변 보내기 함수
SendAnswerToChatGPT(*) {
    ; 현재 답변 내용 가져오기
    answer := answerEdit.Value
    
    ; 클립보드에 답변 내용 복사
    A_Clipboard := answer
    
    ; ChatGPT 웹사이트 열기
    Run "https://chat.openai.com/"
    
    ; 웹사이트가 로드될 때까지 대기
    Sleep 3000
    
    ; Ctrl+V로 답변 내용 붙여넣기
    Send "^v"
}

; Claude로 답변 보내기 함수
SendAnswerToClaude(*) {
    ; 현재 답변 내용 가져오기
    answer := answerEdit.Value
    
    ; 클립보드에 답변 내용 복사
    A_Clipboard := answer
    
    ; Claude 웹사이트 열기
    Run "https://claude.ai/new"
    
    ; 웹사이트가 로드될 때까지 대기
    Sleep 3000
    
    ; Ctrl+V로 답변 내용 붙여넣기
    Send "^v"
}

; Perplexity로 답변 보내기 함수
SendAnswerToPerplexity(*) {
    ; 현재 답변 내용 가져오기
    answer := answerEdit.Value
    
    ; 클립보드에 답변 내용 복사
    A_Clipboard := answer
    
    ; Perplexity 웹사이트 열기
    Run "https://www.perplexity.ai/"
    
    ; 웹사이트가 로드될 때까지 대기
    Sleep 3000
    
    ; Ctrl+V로 답변 내용 붙여넣기
    Send "^v"
}

; 대화 초기화 함수
ResetConversation(*) {
    global messages  ; 전역 변수 참조 선언
    messages.Length := 0  ; 배열 초기화
    questionEdit.Value := ""
    answerEdit.Value := ""
    MsgBox "대화가 초기화되었습니다."
}

; 프로그램 종료 함수
ExitProgram(*) {
    ExitApp
}

; GUI 종료 시 프로그램 종료
OnExit ExitFunc

ExitFunc(ExitReason, ExitCode) {
    ExitApp
} 
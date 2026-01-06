#Requires AutoHotkey v2.0

;====================================================================================
; 프로그램명: ChatGPT 질문답변 프로그램
; 버전: 1.0
; 작성일: 2025-04-26
; 작성자: 신진우    
;====================================================================================
;
; [프로그램 설명]
; - ChatGPT API를 사용하여 질문을 하고 답변을 받을 수 있는 간단한 GUI 프로그램입니다.
; - GPT-4o 모델을 사용하여 더 정확하고 상세한 응답을 생성합니다.
;
; [사용 방법]
; 1. 프로그램 실행 전 OpenAI API 키를 환경 변수에 설정해야 합니다.
;    환경 변수명: OPENAI_API_KEY
; 2. 프로그램을 실행하면 GUI 창이 나타납니다.
; 3. 질문 입력창에 원하는 질문을 입력합니다.
; 4. '질문하기' 버튼을 클릭하면 ChatGPT로부터 답변을 받습니다.
; 5. 답변을 복사하려면 '답변 복사' 버튼을 클릭하세요.
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

; GUI 생성
MyGui := Gui("+Resize", "ChatGPT 질문답변")
MyGui.SetFont("s10", "Malgun Gothic")

; 컨트롤 추가
MyGui.Add("Text",, "질문:")
questionEdit := MyGui.Add("Edit", "vQuestion r3 w500")
; 간략한 답변 요청 체크박스 추가
briefAnswerCheck := MyGui.Add("CheckBox", "vBriefAnswer", "간략한 답변 요청")
; HTML 형식 요청 체크박스 추가
htmlFormatCheck := MyGui.Add("CheckBox", "vHtmlFormat", "HTML 형식 답변")
askButton := MyGui.Add("Button", "Default w100", "질문하기").OnEvent("Click", AskGPT)
chatGPTButton := MyGui.Add("Button", "x+10 w120", "ChatGPT 바로가기").OnEvent("Click", OpenChatGPT)
MyGui.Add("Text", "xm", "답변:")
answerEdit := MyGui.Add("Edit", "vAnswer r10 w500 ReadOnly")
copyBtn := MyGui.Add("Button", "w100", "답변 복사").OnEvent("Click", CopyAnswer)
exitBtn := MyGui.Add("Button", "x+10 w100", "프로그램 종료").OnEvent("Click", ExitProgram)

; GUI 표시
MyGui.Show()

; GPT에 질문하고 답변 받는 함수
AskGPT(*) {
    ; 질문 텍스트 가져오기
    question := questionEdit.Value
    if (question = "") {
        MsgBox "질문을 입력해주세요."
        return
    }

    ; 간략한 답변 요청 체크박스 상태 확인
    if (briefAnswerCheck.Value) {
        question := "다음 질문에 대해 간략하게 답변해주세요: " question
    }

    ; HTML 형식 요청 체크박스 상태 확인
    if (htmlFormatCheck.Value) {
        question := question " (답변은 HTML 형식으로 작성해주세요. 주요 내용은 <h3> 태그로, 일반 내용은 <p> 태그로, 중요 포인트는 <strong> 태그로 표시해주세요.)"
    }

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
    
    ; 요청 데이터 준비
    postData := '{`"model`":`"gpt-4o`",`"messages`":[{`"role`":`"user`",`"content`":`"' escapedQuestion '`"}],`"max_tokens`":500}'

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
                
                ; 답변 표시
                answerEdit.Value := answer
            } else {
                MsgBox "응답 형식이 올바르지 않습니다.`n`n응답: " response
            }
        } catch as e {
            MsgBox "응답 처리 중 오류가 발생했습니다: " e.Message "`n`n응답: " http.ResponseText
        }
    } catch as e {
        MsgBox "API 요청 중 오류가 발생했습니다: " e.Message
    }
}

; 답변 복사 함수
CopyAnswer(*) {
    A_Clipboard := answerEdit.Value
    MsgBox "답변이 클립보드에 복사되었습니다."
}

; ChatGPT 웹사이트 열기 함수
OpenChatGPT(*) {
    Run "https://chat.openai.com/"
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

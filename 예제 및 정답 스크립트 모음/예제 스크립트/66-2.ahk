studyLog := Map()

F1::
{
    studyLog["Date"] := A_Year "-" A_Mon "-" A_MDay
    studyLog["Subject"] := "행정법 총론"
    studyLog["StartTime"] := A_Now
}

F2::
{
    if (studyLog.Count = 0)
    {
        MsgBox("공부 시작 버튼을 먼저 눌러주세요.")
        return
    }
    studyLog["TotalTime"] := A_Now - studyLog["StartTime"]
    MsgBox(
        "날짜: " studyLog["Date"]
        "`n과목: " studyLog["Subject"]
        "`n시작한 시간: " studyLog["StartTime"]
        "`n공부한 시간: " studyLog["TotalTime"] "초"
    )
    ExitApp
}
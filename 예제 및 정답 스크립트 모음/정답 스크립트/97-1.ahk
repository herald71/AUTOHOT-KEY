F1::
{
    static count := 0
    count++
    FileAppend(count "번 눌렀습니다.`n", A_Desktop "\log.txt")
}

F2::
{
    FileDelete(A_Desktop "\log.txt")
    ExitApp
}
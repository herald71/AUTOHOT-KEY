F1::
{
    static count := 0
    count++
    if (FileExist(A_Desktop "\log.txt"))
        FileDelete(A_Desktop "\log.txt")
    FileAppend(count "번 눌렀습니다.`n", A_Desktop "\log.txt")
}

F2::
{
    FileDelete(A_Desktop "\log.txt")
    ExitApp
}
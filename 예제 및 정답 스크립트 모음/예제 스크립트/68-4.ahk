arr := []

F1::
{
    if (arr.Length = 9)
    {
        MsgBox("더는 추가할 수 없습니다!")
        return
    }
    arr.Push({nowTime: A_Now, leftTime: A_TickCount}) ;저는 m으로 A_TickCount를 선택 아무거나 쓰셔도 됩니다.
}

1::printMap(A_ThisHotkey)
2::printMap(A_ThisHotkey)
3::printMap(A_ThisHotkey)
4::printMap(A_ThisHotkey)
5::printMap(A_ThisHotkey)
6::printMap(A_ThisHotkey)
7::printMap(A_ThisHotkey)
8::printMap(A_ThisHotkey)
9::printMap(A_ThisHotkey)
ESC::ExitApp

printMap(pressedKey)
{
    if (arr.Length < pressedKey)
        return
    MsgBox(pressedKey "번 요소의 n과 m`n`nn: " arr[pressedKey].nowTime "`nm: " arr[pressedKey].leftTime)
}

/*
1~9 핫키는 아래와 같이 써서 간략화 할 수 있으나, 강좌에서 설명하지 않은 방식이라 위와 같이 써주었음.

1::
2::
3::
4::
5::
6::
7::
8::
9::
{
    printMap(A_ThisHotkey)
}
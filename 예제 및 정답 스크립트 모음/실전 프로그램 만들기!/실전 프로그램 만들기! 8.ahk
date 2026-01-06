Main := Gui(, "카카오톡 채팅방 분석")
talkContents := Main.Add("Edit", "x10 y10 w290 h100")
Main.Add("Text", "x10 y120", "채팅 횟수")
chatCount := Main.Add("ListBox", "x10 y140 w290 h150")
Main.Show("w310 h300")
talkContents.OnEvent("Change", TalkContents_OnChange)
return

TalkContents_OnChange(obj, info)
{
	contents := talkContents.text
	contents := RegExReplace(contents, " \[.*?\](\[오전|\[오후) ")
	chatPeople := Map()
	chatStat := []
	wordStat := []
	Loop Parse, contents, "`n", "`r"
	{
		RegExMatch(A_LoopField, "\[(.*?)\] (\[오전|\[오후)", &output)
		if (!IsObject(output))
			continue
		if (!chatPeople.Has(output[1]))
			chatPeople[output[1]] := 0
		chatPeople[output[1]] += 1
	}
	for key, value in chatPeople
		chatStat.Push(key ": " value "회")
	chatCount.Delete()
	chatCount.Add(chatStat)
}
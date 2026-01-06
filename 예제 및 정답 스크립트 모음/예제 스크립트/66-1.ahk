sum := 0
report := Map("Korean", 100, "English", 95, "Math", 80, "History", 100 )
for subject, score in report
    sum += score
avarage := sum / report.Count
MsgBox(avarage)
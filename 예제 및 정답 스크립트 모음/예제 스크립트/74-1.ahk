Main := Gui(, "74강 연습")
SliderSender := Main.Add("Slider", "x20 y20 w200")
EditReceiver := Main.Add("Edit", "x20 y60 w200")
Main.Show("w240 h90")
SliderSender.OnEvent("Change", SliderSender_OnChange)
return

SliderSender_OnChange(obj, info)
{
    EditReceiver.Text := obj.Value
}
extends Control


func _ready():
	hide()
	var btn_pause = get_parent().get_node("BtnPause")
	if btn_pause: btn_pause.connect("pressed", self, "_on_pause")
	var btn_resume = get_node("BtnResume")
	if btn_resume:
		btn_resume.connect("pressed", self, "_on_resume")

	
func _on_pause():
	show()
		
func _on_resume():
	hide()

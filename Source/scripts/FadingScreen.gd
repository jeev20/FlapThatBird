extends CanvasLayer


func _ready():
	get_node("Anim").play("AnimScreen")
	yield(get_node("Anim"), "animation_finished")
	get_tree().change_scene("res://Level.tscn")
	



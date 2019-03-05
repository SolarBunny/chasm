extends Node

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _input(event):
	if Input.is_action_just_pressed("r"):
		get_tree().reload_current_scene()
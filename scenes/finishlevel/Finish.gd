extends Area2D

export (String) var level

func _ready():
	$Light.enabled = false
	$Light.texture_scale = 3.155555555555555

func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player":
			get_tree().change_scene(level)
		else:
			continue

func _on_Torch_light():
	$Light.enabled = true
	$Wall/CollisionShape2D2.disabled = true
	$Wall.hide()

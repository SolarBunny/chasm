extends Area2D

signal light
var can_light
var lit

func _ready():
	$Light.enabled = false
	$Light.texture_scale = 1.5
	can_light = false
	$Particles2D.emitting = false
	lit = false

func _process(delta):
	for body in get_overlapping_bodies():
		if body.name == "Player" and not lit:
			can_light = true
	
	if Input.is_action_just_pressed("x") and can_light:
		$AnimatedSprite.play("lit")
		lit = true
		$Light.enabled = true
		$Light.energy = 1
		$lightnoise.play()
		if $Light.enabled == false:
			$Light.enabled = true
		can_light = false
		$Particles2D.emitting = true
		emit_signal("light")
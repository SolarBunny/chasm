extends "res://PhysObj.gd"

signal died
const ACCEL = 20
const MAX_SPEED = 265
var jumpforce = -310
var friction
var walljumpdir

func _ready():
	enable()

func _physics_process(delta):
	
	# movement 
	
	if $AnimatedSprite.scale.x == 1:
		walljumpdir = -1
	elif $AnimatedSprite.scale.x == -1:
		walljumpdir = 1
	
	
	if not is_on_floor() and is_on_wall():
		wallclimb = true
	elif not is_on_wall() and not is_on_floor():
		wallclimb = false
	
	if Input.is_action_pressed("ui_right"):
		movedir.x = min(movedir.x + ACCEL, MAX_SPEED)
		$AnimatedSprite.scale.x = 1
	elif Input.is_action_pressed("ui_left"):
		movedir.x = max(movedir.x - ACCEL, -MAX_SPEED)
		$AnimatedSprite.scale.x = -1
	else:
		movedir.x = lerp(movedir.x, 0, 0.2)
		friction = true
	
	if is_on_floor():
		if Input.is_action_just_pressed("jump"):
			movedir.y = jumpforce
			friction = true
			$jumpnoise.play()
	elif wallclimb:
		if Input.is_action_just_pressed("jump"):
			movedir.y = jumpforce + 50
			friction = true
			$jumpnoise.play()
			push_back(250)
	if Input.is_action_just_released("jump"):
		if movedir.y < -75:
			movedir.y = movedir.y * 0.55
	if friction:
		movedir.x = lerp(movedir.x, 0, 0.05)
	
	# animation manager
	#$AnimatedSprite.frames.set_animation_speed("run", min($AnimatedSprite.frames.get_animation_speed("run")*1.15, 30))
	if movedir.x != 0 and is_on_floor():
		$AnimatedSprite.play("run")
	elif movedir.y < 0:
		$AnimatedSprite.play("jump")
	elif movedir.y > 0:
		$AnimatedSprite.play("fall")
	elif is_on_floor() and movedir.x == 0:
		$AnimatedSprite.play("default")
	if not is_on_floor() and is_on_wall():
		$AnimatedSprite.play("wallclimb")

func push_back(DIR):
	movedir.x = DIR * walljumpdir

func enable():
	$PlayerLight.enabled = true
	$PlayerLight.energy = 1
	if $PlayerLight.enabled == false:
		print("AAAA")
		$PlayerLight.enabled = true
		$PlayerLight.energy = 1

func die():
	get_tree().reload_current_scene()
	queue_free()
extends KinematicBody2D

var movedir = Vector2()
var wallclimb
const GRAVITY = Vector2(0, 575)
const WALLGRAV = Vector2(0, 250)
const FLOOR_NORMAL = Vector2(0, -1)

func _physics_process(delta):
	if not wallclimb:
		movedir += GRAVITY * delta
	elif wallclimb:
		movedir.y += 250 * delta
	movedir = move_and_slide(movedir, FLOOR_NORMAL)
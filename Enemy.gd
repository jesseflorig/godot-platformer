extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20

var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	
	motion = move_and_slide(motion, UP)
	pass

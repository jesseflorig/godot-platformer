extends KinematicBody2D

const DEBUG = false
const UP = Vector2(0, -1)
const GRAVITY = 20
const SPEED = 200
const JUMP_SPEED = -550
const DOUBLE_JUMP_SPEED = -400
const COMBO_TIMEOUT = 0.3
const MAX_COMBO_CHAIN = 2

var motion = Vector2()
var last_key_delta = 0
var key_combo = []

func console(msg):
	if DEBUG:
		print(msg)
	return
	

func _input(event):
	if event is InputEventKey and event.pressed and !event.echo:
		print(last_key_delta)
		if last_key_delta > COMBO_TIMEOUT:
			key_combo = []
		
		key_combo.append(event.scancode)
		if key_combo.size() > MAX_COMBO_CHAIN:
			key_combo.pop_front()
		
		print(key_combo)
		last_key_delta = 0
		
	
func is_jumping():
	return is_on_floor() and Input.is_action_just_pressed("ui_up")


func is_double_jumping():
	return !is_on_floor() and Input.is_action_just_pressed("ui_up")


func _physics_process(delta):
	last_key_delta += delta
	motion.y += GRAVITY


	if Input.is_action_pressed("ui_left"):
		console("left")
		motion.x = -SPEED	
	elif Input.is_action_pressed("ui_right"):
		console("right")
		motion.x = SPEED
	else:
		console("stop")
		motion.x = 0
		
	if is_jumping():
		console("jump")
		motion.y = JUMP_SPEED
	elif is_double_jumping():
		console("double jump")
		motion.y = DOUBLE_JUMP_SPEED
	
	motion = move_and_slide(motion, UP)
	pass
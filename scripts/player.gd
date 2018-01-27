extends KinematicBody2D

export var speed = 70
signal game_over
var locker_available = false
var doors_available = false
var count = 30

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if locker_available:
		if Input.is_action_pressed("interact") && count >= 30:
			if is_visible():
				hide()
			else:
				show()
			count = 0
	if doors_available:
		if Input.is_action_pressed("interact") && count >= 30:
			print('do stuff')
			count = 0
	count += 1
	if is_visible():
		var dir = Input.is_action_pressed("move_right") - Input.is_action_pressed("move_left")
		var motion = move(Vector2(dir*speed*delta, 0))
	if is_colliding():
		emit_signal("game_over")
		pass
	pass

func on_locker_available(body):
	locker_available = true
	pass
	
func on_locker_not_available(body):
	locker_available = false
	pass

func on_doors_available(body):
	doors_available = true
	pass

func on_doors_not_available(body):
	doors_available = false
	pass

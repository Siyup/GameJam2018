extends KinematicBody2D

export var speed = 5

func _ready():
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var dir = Input.is_action_pressed("move_right") - Input.is_action_pressed("move_left")
	var motion = move(Vector2(dir*speed, 0))
	pass

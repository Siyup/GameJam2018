extends KinematicBody2D

var initial_pos = Vector2()
var dir = 1
export var speed = 20
export var radius = 50

func _ready():
	initial_pos = get_pos()
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var motion = speed * delta
	if get_pos().x + motion*dir > initial_pos.x + radius:
		dir *= -1
	if get_pos().x + motion*dir < initial_pos.x - radius:
		dir *= -1
	move(Vector2(delta * speed * dir, 0))
	pass
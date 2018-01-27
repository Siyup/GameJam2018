extends KinematicBody2D

var initial_pos = Vector2()
var dir = 1
var alert = false
var player
export var speed = 20
export var radius = 50

func _ready():
	initial_pos = get_pos()
	get_node("visionarea").connect("body_enter", self, "on_vision")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	var motion = speed * delta
	if get_pos().x + motion*dir > initial_pos.x + radius:
		dir *= -1
	if get_pos().x + motion*dir < initial_pos.x - radius:
		dir *= -1
	if alert:
		var player_pos = player.get_pos()
		var newDir = Vector2(player_pos.x - get_pos().x, 0).normalized()
		move(Vector2(motion*newDir.x, 0))
	else:
		move(Vector2(motion * dir, 0))
	pass

func on_vision(body):
	alert = true
	player = body
	speed *= 5
	pass
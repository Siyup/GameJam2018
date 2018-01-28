extends KinematicBody2D

var initial_pos = Vector2()
var dir = 1
var alert = false
var player
var playerInRange = false
var speed = 40
export var initialSpeed = 40
export var rageSpeed = 200
export var radius = 500
signal game_over

func _ready():
	speed = initialSpeed
	add_to_group("enemy")
	initial_pos = get_pos()
	get_node("visionarea").connect("body_enter", self, "on_vision")
	get_node("visionarea").connect("body_exit", self, "on_vision_end")
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if is_colliding():
		emit_signal("game_over")
	var motion = speed * delta
	if get_pos().x + motion*dir > initial_pos.x + radius:
		dir *= -1
	if get_pos().x + motion*dir < initial_pos.x - radius:
		dir *= -1
	if playerInRange && player.is_visible():
		alert = true
		motion = rageSpeed * delta
	if alert:
		var player_pos = player.get_pos()
		var newDir = Vector2(player_pos.x - get_pos().x, 0).normalized()
		move(Vector2(motion*newDir.x, 0))
	else:
		move(Vector2(motion * dir, 0))
	pass

func on_vision(body):
	player = body
	playerInRange = true
	if player.is_visible():
		alert = true
		speed = rageSpeed
	pass

func on_vision_end(body):
	playerInRange = false
	pass
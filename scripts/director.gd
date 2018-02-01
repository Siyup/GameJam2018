extends KinematicBody2D

var initial_pos = Vector2()
export var dir = 1
export var randomNumber = 700
var alert = false
var player
var playerInRange = false
var speed = 40
export var initialSpeed = 40
export var rageSpeed = 300
export var radius = 500
export var floorNumber = 1
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
		get_node("rageTimer").start()
		motion = rageSpeed * delta
	if alert:
		if player!= null && player.is_visible() && player.floor_number == floorNumber:
			var player_pos = player.get_pos()
			var newDir = Vector2(player_pos.x - get_pos().x, 0).normalized()
			get_node("rage_sprite").show()
			move(Vector2(motion*newDir.x, 0))
		else:
			move(Vector2(motion * dir, 0))
	else:
		randomize_movement(dir)
		adjust_vision(dir)
		move(Vector2(motion * dir, 0))
		get_node("rage_sprite").hide()
	pass

func on_vision(body):
	player = body
	playerInRange = true
	if player.is_visible():
		alert = true
		get_node("rageTimer").start()
		speed = rageSpeed
	pass

func on_vision_end(body):
	playerInRange = false
	pass

func adjust_vision(newDir):
	if newDir == 1:
			get_node("animation").set_flip_h(true)
			get_node("visionarea").set_pos(Vector2(95, 0))
			get_node("visionarea/sprite").set_flip_v(true)
			get_node("visionarea/sprite").set_rot(255*PI/180)
	elif newDir == -1:
			get_node("animation").set_flip_h(false)
			get_node("visionarea").set_pos(Vector2(-95, 0))
			get_node("visionarea/sprite").set_flip_v(false)
			get_node("visionarea/sprite").set_rot(-75*PI/180)
	pass

func randomize_movement(dir):
	randomize()
	var random = randi() % randomNumber
	if random == 1:
		self.dir *= -1
		get_node("visionTimer").start()

func _on_rageTimer_timeout():
	alert = false
	playerInRange = false
	speed = initialSpeed
	pass # replace with function body


func _on_visionTimer_timeout():
	self.dir *= -1
	pass # replace with function body

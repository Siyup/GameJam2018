extends KinematicBody2D
export var speed = 160
signal game_over
signal pause
signal game_win
var locker
var current_doors = null
var locker_available = false
var doors_available = false
var count = 20
var doors_width
var floor_height = 225
export var floor_number = 3
func _ready():
	doors_width=128*1.1/2
	set_fixed_process(true)
	pass

func _fixed_process(delta):
	if Input.is_action_pressed("pause"):
		emit_signal("pause")
	if locker_available:
		if Input.is_action_pressed("interact") && count >= 20:
			if locker.special_locker:
				emit_signal("game_win")
			else:
				if is_visible():
					locker.get_node("eyes").show()
					locker.get_node("Sprite").hide()
					locker.get_node("closed").show()
					hide()
				else:
					locker.get_node("eyes").hide()
					locker.get_node("Sprite").show()
					locker.get_node("closed").hide()
					show()
			count = 0
	if doors_available || (current_doors != null && (current_doors.get_pos().x + doors_width >= get_pos().x && current_doors.get_pos().x - doors_width <= get_pos().x)):
		if Input.is_action_pressed("interact") && count >= 10:
			set_pos(current_doors.teleport_location)
			floor_number = get_floor_number()
			count = 0
	count += 1
	if is_visible():
		var dir = Input.is_action_pressed("move_right") - Input.is_action_pressed("move_left")
		if dir == 1:
			get_node("main_sprite").play("walk")
			get_node("main_sprite").set_flip_h(true)
			get_node("letter_sprite").set_rot(55*(PI/180))
			get_node("letter_sprite").set_pos(Vector2(28,6.7))
		elif dir == -1:
			get_node("main_sprite").play("walk")
			get_node("main_sprite").set_flip_h(false)
			get_node("letter_sprite").set_rot(-55*(PI/180))
			get_node("letter_sprite").set_pos(Vector2(-28,6.7))
		else:
			get_node("main_sprite").stop()
		var motion = move(Vector2(dir*speed*delta, 0))
	if is_colliding():
		emit_signal("game_over")
		pass
	pass

func on_locker_available(body):
	locker_available = true
	locker = body
	pass
	
func on_locker_not_available(body):
	locker_available = false
	pass

func on_doors_available(body, doors):
	current_doors = doors
	doors_available = true
	pass

func on_doors_not_available(body):
	doors_available = false
	pass

func get_floor_number():
	return 4 - round(get_pos().y/floor_height)
	pass
extends Node

func _ready():
	get_node("player").connect("game_over", self, "on_game_over")
	get_node("player").connect("pause", self, "on_pause")
	get_node("HUD").get_node("game_over").get_node("play_again").connect("button_down", self, "on_restart")
	get_node("director").connect("game_over", self, "on_game_over")
	get_node("director").get_node("enemycollision").connect("body_enter", self, "on_game_over")
	for locker in get_node("lockers container").get_children():
		locker.connect("body_enter", get_node("player"), "on_locker_available")
		locker.connect("body_exit", get_node("player"), "on_locker_not_available")
	for doors in get_node("doors container").get_children():
		doors.connect("doors_available", get_node("player"), "on_doors_available")
		doors.connect("body_exit", get_node("player"), "on_doors_not_available")
	
	var pairs_number = get_node("doors container").get_child_count()/2
	for i in range(pairs_number):
		var first = get_node("doors container").get_child(0+i*2)
		var second = get_node("doors container").get_child(1+i*2)
		first.set_teleport_location(second.get_pos()+Vector2(0,30))
		second.set_teleport_location(first.get_pos()+Vector2(0,30))
	pass

func on_game_over(body):
	if get_node("player").is_visible():
		get_node("HUD").get_node("game_over").show()
		get_tree().set_pause(true)
	pass

func on_restart():
	get_node("player").set_pos(Vector2(63,127))
	get_node("director").alert = false
	get_node("director").playerInRange = false
	get_node("director").speed = get_node("director").initialSpeed
	get_node("HUD").get_node("game_over").hide()
	get_tree().set_pause(false)
	pass

func on_pause(body):
	get_tree().set_pause(true)
	pass
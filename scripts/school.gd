extends Node

func _ready():
	get_node("player").connect("game_over", self, "on_game_over")
	get_node("director").connect("game_over", self, "on_game_over")
	get_node("locker").connect("body_enter", get_node("player"), "on_locker_available")
	get_node("locker").connect("body_exit", get_node("player"), "on_locker_not_available")
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

func on_game_over():
	if get_node("player").is_visible():
		get_tree().set_pause(true)
	pass

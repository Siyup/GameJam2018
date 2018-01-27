extends Node


func _ready():
	get_node("player").connect("game_over", self, "on_game_over")
	get_node("director").connect("game_over", self, "on_game_over")
	get_node("locker").connect("body_enter", get_node("player"), "on_locker_available")
	get_node("locker").connect("body_exit", get_node("player"), "on_locker_not_available")
	for doors in get_node("doors container").get_children():
		doors.connect("body_enter", get_node("player"), "on_doors_available")
		doors.connect("body_enter", get_node("player"), "on_doors_not_available")
	pass

func on_game_over():
	if get_node("player").is_visible():
		get_tree().set_pause(true)
	pass

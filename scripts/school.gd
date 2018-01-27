extends Node


func _ready():
	get_node("player").connect("game_over", self, "on_game_over")
	pass

func on_game_over():
	get_tree().set_pause(true)
	pass

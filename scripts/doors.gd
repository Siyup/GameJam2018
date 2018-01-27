extends Area2D

export var teleport_location = Vector2()
signal doors_available

func _ready():
	pass

func set_teleport_location(pos):
	teleport_location = pos
	pass

func _on_doors_body_enter( body ):
	print('iejo')
	print(get_pos())
	emit_signal("doors_available", body, self)
	pass # replace with function body

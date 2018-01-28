extends CanvasLayer

signal restart

func _ready():
	# Called every time the node is added to the scene.
	# Initialization here
	pass


func _on_play_again_pressed():
	emit_signal("restart")
	pass # replace with function body

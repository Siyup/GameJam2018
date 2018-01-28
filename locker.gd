extends Area2D

signal locker_available
export var special_locker = false

func _ready():
	pass


func _on_locker_body_enter( body ):
	emit_signal("locker_available", self)
	pass # replace with function body

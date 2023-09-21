class_name GameManager
extends Node

@onready var _levelNode: Node = $LoadedLevel


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.



func loadLevel(level: PackedScene):
	if _levelNode != null:
		for childNode in _levelNode.get_children():
			childNode.queue_free()
		_levelNode.add_child(level.instantiate())
class_name LevelTransition
extends Area3D

@export var nextLevel: PackedScene

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(collide)


func collide(body: Node3D):
	print(nextLevel)
	if nextLevel != null:
		if body.is_in_group("Player"):
			print("Hello World")
			var curScene = get_tree().current_scene
			if curScene is GameManager:
				curScene.loadLevel(nextLevel);
@tool
class_name SpikeArray
extends Node3D

@export var SpikeCount: int = 4;
@export var SpikeDistance: float = .55;
var spikeScene: PackedScene = preload("res://Levels/BuildingBlocks/Spike.tscn")
	
# Called when the node enters the scene tree for the first time.
func _ready():
	var distance: float = 0;
	for i in SpikeCount:
		var newSpike = spikeScene.instantiate()
		newSpike.position.x += distance
		distance+= SpikeDistance
		add_child(newSpike)
		newSpike.owner = get_tree().edited_scene_root
	


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

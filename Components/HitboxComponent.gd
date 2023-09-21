class_name HitboxComponent
extends Area3D

@onready var _healthComponent: HealthComponent = $HealthComponent

# Called when the node enters the scene tree for the first time.
func _ready():
	area_entered.connect(hit)


func hit(otherArea: Area3D):
	if otherArea is HurtboxComponent:
		otherArea.applyDamage(_healthComponent)

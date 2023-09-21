class_name HealthComponent
extends Node


@export var CurrentHP: int = 1:
	set(val):
		if val != CurrentHP:
			var old = CurrentHP
			CurrentHP = clamp(val, 0 ,MaxHP)
			HealthChanged.emit(old,CurrentHP)
			if CurrentHP == 0:
				Died.emit();
	get:
		return CurrentHP

@export var MaxHP: int = 1:
	set(val):
		MaxHP = clamp(val,0,MaxHP)
		if CurrentHP < MaxHP:
			CurrentHP = MaxHP
	get:
		return MaxHP


var _inHitstun: bool = false:
	set(val):
		_inHitstun = val
		if val:
			EnteredHitStun.emit()
		else:
			ExitedHitstun.emit()
	get:
		return _inHitstun


@export var HitStunTime: float = .1
var _remainingHitStunTime: float = 0

func applyDamage(damage: int):
	if !_inHitstun:
		CurrentHP -= damage
		if HitStunTime != 0:
			_remainingHitStunTime = HitStunTime
			_inHitstun = true

signal HealthChanged(oldHealth: int, newHealth: int);
signal Died;
signal EnteredHitStun;
signal ExitedHitstun;
	
			

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if _inHitstun:
		_remainingHitStunTime -= delta;
		if _remainingHitStunTime <=0:
			_inHitstun = false
	

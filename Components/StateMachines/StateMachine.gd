class_name StateMachine
extends Node

@export var defaultState: State
var _currentState: State

# Called when the node enters the scene tree for the first time.
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	_currentState.update(delta)
	if _currentState.nextState!=null:
		_currentState.exit()
		var nextState: State = _currentState.nextState
		_currentState.nextState = null
		_currentState = nextState
		_currentState.enter()


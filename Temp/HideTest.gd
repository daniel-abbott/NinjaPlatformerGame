extends Area3D


func _ready() -> void:
	body_entered.connect(_body_entered)
	body_exited.connect(_body_exited)
	$Label3D.visible = false


func _body_entered(body: Node3D) -> void:
	if body is Player:
		$Label3D.visible = true


func _body_exited(body: Node3D) -> void:
	if body is Player:
		$Label3D.visible = false

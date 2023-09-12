class_name Player
extends CharacterBody3D


const SPEED := 5.0
const JUMP_VELOCITY := 4.5

# permanent upgrades, these should persist between levels
const UPGRADES := {
	"jump_boots": false, # double jump
	"claws": false # stick to walls instead of sliding
}

# temporary powerups/boosts
const POWERUPS := {
	"speed": false # speed boost
}

var gravity: float = ProjectSettings.get_setting("physics/3d/default_gravity")
var hidden := false
var can_wall_jump := true
var is_wall_jumping := false
var last_wall_normal: float
var can_double_jump := false

# onready nodes
@onready var camera_pivot := $CameraPivot
@onready var camera_position := $CameraPivot/CameraPosition
@onready var camera := $CameraPivot/CameraPosition/Camera3D
@onready var sprite := $AnimatedSprite3D
@onready var collision := $CollisionShape3D


#func _process(delta: float) -> void:
#	pass


func _physics_process(delta: float) -> void:
	camera.global_position = lerp(camera.global_position, camera_position.global_position, delta * 2.0)
	camera.look_at(position, Vector3.UP)

	if not is_on_floor() or not hidden:
		velocity.y -= gravity * delta
	
	if is_on_ceiling() and UPGRADES.claws:
		velocity.y = 0

	var direction := Vector3(Input.get_axis("move_right", "move_left"), 0, 0).normalized()
	
	if is_on_floor() or (is_on_ceiling() and UPGRADES.claws):
		velocity.x = lerp(velocity.x, 0.0, delta * 60.0) # fake friction, TODO air friction/control

	if direction:
		if is_on_floor(): velocity.x += direction.x * SPEED
		if is_on_ceiling() and UPGRADES.claws: velocity.x += direction.x * (SPEED * 0.2)
		camera_pivot.rotation.y = clamp(camera_pivot.rotation.y - (direction.x * 0.1), -0.1, 0.1)
		if is_on_wall() and not is_on_floor():
			if velocity.y < 0.0:
				velocity.y *= 0.8 if not UPGRADES.claws else 0.0 # wall grip if we have the claws upgrade
	else:
		camera_pivot.rotation.y = 0.0

	if Input.is_action_just_pressed("jump"):
		if is_on_ceiling() and UPGRADES.claws:
			velocity.y = -JUMP_VELOCITY
		if not is_on_floor() and can_double_jump:
			can_double_jump = false
			velocity.y = JUMP_VELOCITY * 1.5
		if is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_wall_jumping = false
			can_wall_jump = true
			if UPGRADES.jump_boots: can_double_jump = true
		if is_on_wall() and not is_on_floor() and can_wall_jump:
			can_wall_jump = false if last_wall_normal == get_wall_normal().normalized().x else true
			is_wall_jumping = true
			last_wall_normal = get_wall_normal().normalized().x
			velocity.x += last_wall_normal * SPEED
			velocity.y = JUMP_VELOCITY

	move_and_slide()

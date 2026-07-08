extends Node3D

class_name Fish

var rng: RandomNumberGenerator

@onready var destination: Vector3 = global_position
@export var animator: AnimationPlayer
@export var mesh: MeshInstance3D
@export var audio: AudioStreamPlayer
var timer: Timer

func _ready() -> void:
	rng = RandomNumberGenerator.new()
	rng.randomize()
	timer = Timer.new()
	add_child(timer)
	update_destination()
	timer.timeout.connect(update_destination)

func _process(delta: float) -> void:
	global_position = lerp(global_position,destination,delta)
	if global_position != destination:
		var current_quat: Quaternion = global_transform.basis.get_rotation_quaternion()
	
		var target_basis: Basis = global_transform.looking_at(
			destination, Vector3.UP
		).basis
		var target_quat: Quaternion = target_basis.get_rotation_quaternion()
		
		# Ensure shortest path (avoids weird flips)
		if current_quat.dot(target_quat) < 0.0:
			target_quat = -target_quat
		
		var result_quat = current_quat.slerp(target_quat, delta)
		global_transform.basis = Basis(result_quat)
	animator.speed_scale = global_position.distance_squared_to(destination)

func update_destination() -> void:
	destination = Vector3(rng.randf_range(-1,1),rng.randf_range(0.5,3),rng.randf_range(-4,4))
	timer.start(rng.randf_range(3,5))
	audio.play()

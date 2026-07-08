extends Node3D

@export var fishes: Array[PackedScene]

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	FishServer.add_fish.connect(add_fish)

func add_fish(fish: int, texture: Texture2D):
	var spawned: Fish = fishes[fish].instantiate()
	add_child(spawned)
	(spawned.mesh.material_override as StandardMaterial3D).albedo_texture = texture
	$splash.play()

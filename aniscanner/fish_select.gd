extends CheckBox

@export var texture: Texture
@export var reference: TextureRect
@export var ref_number: int

# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	reference.texture = texture
	SendFish.fish = ref_number

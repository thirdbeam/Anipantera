extends CheckBox

@export var texture: Texture
@export var reference: TextureRect

# Called when the node enters the scene tree for the first time.
func _pressed() -> void:
	reference.texture = texture

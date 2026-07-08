extends Button


func _pressed() -> void:
	SendFish.texture = $"../../TextureRect".texture.duplicate()
	SendFish.submit()

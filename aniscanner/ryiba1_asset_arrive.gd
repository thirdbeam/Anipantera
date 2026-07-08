extends Button

@onready var my_image = $TextureRect

func _ready() -> void:
	my_image.visible = false

func _on_toggled(toggled_on: bool) -> void:
	my_image.visible = toggled_on

extends Button


func _pressed() -> void:
	SendFish.ip = "http://" + $"../TextEdit".text + ":8080/send_fish"
	
	get_tree().change_scene_to_file("res://scenes/drawing_scene.tscn")

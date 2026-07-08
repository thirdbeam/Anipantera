@tool
extends QRCodeRect


func _ready() -> void:
	generate()

func generate() -> void:
	var ip = Array(IP.get_local_addresses()).filter(func(a): return a.begins_with("192.168.") or a.begins_with("10.") or a.begins_with("172.")).pick_random()
	set_data(ip)

func _gui_input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed():
		generate()

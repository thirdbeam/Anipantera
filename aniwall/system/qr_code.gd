@tool
extends QRCodeRect


func _ready() -> void:
	var ip = Array(IP.get_local_addresses()).filter(func(a): return a.begins_with("192.168.") or a.begins_with("10.") or a.begins_with("172.")).front()
	set_data(ip)

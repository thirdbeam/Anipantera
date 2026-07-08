extends HTTPRequest

var ip: String
var texture: Texture2D
var fish: int

signal submitted

func submit() -> void:
	var byte_request: PackedByteArray = PackedByteArray()
	byte_request.resize(1)
	byte_request.encode_u8(0,fish)
	byte_request.append_array(texture.get_image().save_png_to_buffer())
	
	var stringed: PackedStringArray = PackedStringArray(Array(byte_request))
	
	cancel_request()
	request(ip,PackedStringArray(),HTTPClient.METHOD_POST," ".join(stringed))
	submitted.emit()

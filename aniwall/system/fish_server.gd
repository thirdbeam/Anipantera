extends Node

var server: HttpServer

signal add_fish(fish_type: int, texture: Texture2D)

func _ready() -> void:
	server = HttpServer.new()
	
	var homepage: HttpRouter = HttpRouter.new('/',
	{
		'get': home_page
		})
	var fish_send: HttpRouter = HttpRouter.new('/send_fish',
	{
		'post': recieve_fish
	})
	
	server.register_router(homepage)
	server.register_router(fish_send)
	
	add_child(server)
	server.start()

func home_page(_request: HttpRequest, response: HttpResponse) -> bool:
	response.send(200,'<h1>Hello, world!</p>')
	return true

func recieve_fish(request: HttpRequest, _response: HttpResponse) -> bool:
	var split_array = request.body.split(" ")
	var extracted_fish_type = split_array[0]
	split_array.remove_at(0)

	var array := PackedByteArray()
	array.resize(split_array.size())
	for i in split_array.size():
		array[i] = int(split_array[i])

	var fish_type: int = int(extracted_fish_type)

	var image := Image.new()
	var err := image.load_png_from_buffer(array)
	if err != OK:
		print("Failed to decode PNG: ", err)
		return false

	add_fish.emit.call_deferred(fish_type, ImageTexture.create_from_image(image))
	return true

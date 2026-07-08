extends Node

var server: HttpServer

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
	print(request.body)
	return true

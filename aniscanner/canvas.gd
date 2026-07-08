extends TextureRect

@export var color_picker: ColorPicker

var is_drawing = false
var last_point: Vector2
var brush_size: int = 10



func _ready():
	# Создаём пустое изображение для рисования
	SendFish.submitted.connect(clear)
	await get_tree().process_frame
	var image = Image.create(int(size.x), int(size.y), false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT) # белый фон
	texture = ImageTexture.create_from_image(image)

func clear():
	var image = Image.create(int(size.x), int(size.y), false, Image.FORMAT_RGBA8)
	image.fill(Color.TRANSPARENT) # белый фон
	texture = ImageTexture.create_from_image(image)

func _input(event: InputEvent):
	# Проверяем, что мышь находится внутри области рисования
	if not Rect2(Vector2.ZERO, size).has_point(get_local_mouse_position()):
		return
	
	# Начало рисования (зажата левая кнопка)
	if event is InputEventMouseButton and event.button_index == MOUSE_BUTTON_LEFT:
		if event.pressed:
			is_drawing = true
			last_point = get_local_mouse_position()
			draw_circle_hren(last_point)
		else:
			is_drawing = false
	
	# Рисование при движении мыши
	if event is InputEventMouseMotion and is_drawing:
		var current_point = get_local_mouse_position()
		draw_line_hren(last_point, current_point)
		last_point = current_point

func draw_circle_hren(pos: Vector2):
	var image = texture.get_image()
	var color = color_picker.color # берём цвет из ColorPicker
	
	# Рисуем кружок радиусом 10 пикселей
	image.fill_rect(Rect2(pos - Vector2(brush_size/2, brush_size/2), Vector2(brush_size, brush_size)), color)
	
	texture = ImageTexture.create_from_image(image)

func draw_line_hren(from: Vector2, to: Vector2):
	var image = texture.get_image()
	var color = color_picker.color
	
	var cool_alg: int = int(round(from.distance_to(to)))
	
	for i in range(cool_alg):
		var in_point: Vector2 = from.lerp(to,float(i)/cool_alg)
		image.fill_rect(Rect2(in_point - Vector2(brush_size/2, brush_size/2), Vector2(brush_size, brush_size)), color)
		
	
	texture = ImageTexture.create_from_image(image)


func _on_h_slider_value_changed(value: float) -> void:
		brush_size = value

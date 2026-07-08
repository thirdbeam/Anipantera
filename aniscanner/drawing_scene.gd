extends Control

@onready var drawing_area = $TextureRect
@onready var color_picker = $ColorPicker

var is_drawing = false
var last_point: Vector2

func _ready():
	# Создаём пустое изображение для рисования
	var image = Image.create(800, 600, false, Image.FORMAT_RGBA8)
	image.fill(Color.WHITE) # белый фон
	drawing_area.texture = ImageTexture.create_from_image(image)

func _input(event: InputEvent):
	# Проверяем, что мышь находится внутри области рисования
	if not Rect2(Vector2.ZERO, drawing_area.size).has_point(get_local_mouse_position()):
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
	var image = drawing_area.texture.get_image()
	var color = color_picker.color # берём цвет из ColorPicker
	
	# Рисуем кружок радиусом 10 пикселей
	image.fill_rect(Rect2(pos - Vector2(5, 5), Vector2(10, 10)), color)
	
	drawing_area.texture = ImageTexture.create_from_image(image)

func draw_line_hren(from: Vector2, to: Vector2):
	var image = drawing_area.texture.get_image()
	var color = color_picker.color
	
	# Рисуем линию толщиной 10 пикселей
	image.fill_rect(Rect2(to - Vector2(5, 5), Vector2(10, 10)), color)
	
	drawing_area.texture = ImageTexture.create_from_image(image)

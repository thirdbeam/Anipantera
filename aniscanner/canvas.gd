extends TextureRect

# Переменные для рисования
var image: Image
var is_drawing: bool = false
var current_color: Color = Color.BLACK
var brush_size: int = 5
var image_path: String = "res://Rybachyort2.png"  # Путь к вашему изображению

func _ready():
	load_image()

# Загрузка существующего изображения
func load_image():
	# Загружаем изображение из файла
	var loaded_image = Image.load_from_file("res://Rybachyort2.png")
	
	if loaded_image:
		image = loaded_image
		# Создаем текстуру из загруженного изображения
		texture = ImageTexture.create_from_image(image)
		print("Изображение загружено: ", image_path)
	else:
		# Если файл не найден, создаем пустой холст
		image = Image.create(size.x, size.y, false, Image.FORMAT_RGBA8)
		image.fill(Color.WHITE)
		texture = ImageTexture.create_from_image(image)
		print("Изображение не найдено, создан пустой холст")

# Получение цвета из ColorPickerButton
func _on_color_picker_color_changed(color: Color):
	current_color = color  # Запоминаем выбранный цвет
	print("Выбран цвет: ", color)

# Рисование пикселя на изображении
func _draw_pixel_at(position: Vector2):
	# Проверяем, что позиция внутри изображения
	var pixel_pos = Vector2i(position)
	
	if pixel_pos.x < 0 or pixel_pos.x >= image.get_width() or pixel_pos.y < 0 or pixel_pos.y >= image.get_height():
		return
	
	# Рисуем квадратную кисть
	var half_brush = brush_size / 2
	for x in range(-half_brush, half_brush + 1):
		for y in range(-half_brush, half_brush + 1):
			var draw_pos = pixel_pos + Vector2i(x, y)
			
			# Проверяем границы изображения
			if draw_pos.x >= 0 and draw_pos.x < image.get_width() and draw_pos.y >= 0 and draw_pos.y < image.get_height():
				image.set_pixelv(draw_pos, current_color)
	
	# Обновляем текстуру
	(texture as ImageTexture).update(image)

# Обработка событий мыши
func _gui_input(event: InputEvent):
	# Нажатие кнопки мыши
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			if event.pressed:
				is_drawing = true
				_draw_pixel_at(event.position)  # Рисуем в месте клика
				print("Начало рисования")
			else:
				is_drawing = false
				print("Конец рисования")
	
	# Движение мыши (рисуем только если зажата кнопка)
	if event is InputEventMouseMotion and is_drawing:
		_draw_pixel_at(event.position)

# Загрузка нового изображения
func load_new_image(new_path: String):
	image_path = new_path
	load_image()

# Сохранение измененного изображения
func save_image(path: String = "user://drawing.png"):
	var error = image.save_png(path)
	if error == OK:
		print("Изображение сохранено: ", path)
		return true
	else:
		print("Ошибка сохранения: ", error)
		return false

# Получение цвета пикселя (для пипетки)
func get_pixel_color(mouse_position: Vector2) -> Color:
	var pixel_pos = Vector2i(mouse_position)
	if pixel_pos.x >= 0 and pixel_pos.x < image.get_width() and pixel_pos.y >= 0 and pixel_pos.y < image.get_height():
		return image.get_pixelv(pixel_pos)
	return Color.BLACK

# Очистка (заливка белым)
func clear_canvas():
	image.fill(Color.WHITE)
	(texture as ImageTexture).update(image)
	print("Холст очищен")

# Установка размера кисти
func set_brush_size(new_size: int):
	brush_size = max(1, new_size)
	print("Размер кисти: ", brush_size)

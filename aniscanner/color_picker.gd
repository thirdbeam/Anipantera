extends ColorPicker

@export var color_picker_button : ColorPickerButton
var selected_color : Color

func _ready():
	# Подключаемся к сигналу, который срабатывает при выборе нового цвета
	color_picker_button.color_changed.connect(_on_color_changed)

func _on_color_changed(color: Color):
	# Сохраняем выбранный цвет, чтобы использовать его для рисования
	selected_color = color
	print("Новый цвет выбран: ", selected_color)

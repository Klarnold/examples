class_name Description extends Control


@onready var _text_label: Label = %TextLabel


func _ready() -> void:
	var screen_position: Vector2 = get_screen_position() # TODO сделать человечную вёрстку
	var screen_size: Vector2 = get_viewport_rect().size
	if (screen_position.x + size.x) >= screen_size.x:
		position.x -= 520
	elif (screen_position.x + size.x) < size.x:
		position.x += 520
	elif (screen_position.y + _text_label.get_line_count() * _text_label.get_theme_font_size("font_size")) >= screen_size.y:
		position.y -= _text_label.get_line_count() * _text_label.get_theme_font_size("font_size")
	elif (screen_position.y + _text_label.get_line_count() * _text_label.get_theme_font_size("font_size")) < size.y:
		position.y += _text_label.get_line_count() * _text_label.get_theme_font_size("font_size")

func show_itself() -> void:
	visible = true



func hide_itself() -> void:
	visible = false


func set_text(text: String) -> void:
	_text_label.text = text

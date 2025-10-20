class_name Credits extends Node3D


signal show_main_menu


@export var credits_speed: float = 300.0


@onready var _credits_text_1: Label3D = %CreditsText1
@onready var _credits_text_2: Label3D = %CreditsText2
@onready var _credits_text_3: Label3D = %CreditsText3
@onready var _credits_text_4: Label3D = %CreditsText4
@onready var _credits_text_5: Label3D = %CreditsText5
@onready var _return_button: Button = %ReturnButton


var _credits_all: Array[Label3D]


func _ready() -> void:
	_return_button.pressed.connect(_on_return_button_pressed)
	
	_credits_all.append(_credits_text_1)
	_credits_all.append(_credits_text_2)
	_credits_all.append(_credits_text_3)
	_credits_all.append(_credits_text_4)
	_credits_all.append(_credits_text_5)


func _physics_process(delta: float) -> void:
	for credits_text: Label3D in _credits_all:
		credits_text.global_position.y += delta
		if credits_text.position.y > 4.5:
			credits_text.global_position.y = -3.0


func _on_return_button_pressed() -> void:
	show_main_menu.emit()
	
	call_deferred("queue_free")

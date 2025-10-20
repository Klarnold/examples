class_name DamageIndicator extends Node2D


@onready var damage_label: Label = %DamageLabel


func display_amount(amount: float) -> void:
	damage_label.text = str(snappedf(amount, 0.01))
	position.x += randf_range(-32.0, 32.0)

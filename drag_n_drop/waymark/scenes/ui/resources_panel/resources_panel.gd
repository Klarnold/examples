class_name ResourcesPanel extends VBoxContainer


@onready var _money_label: RichTextLabel = %MoneyLabel


func _ready() -> void:
	var _character: Character = get_tree().get_first_node_in_group("character")
	
	assert(_character != null, "_character in ResourcePanel %s is null. It must be an instance of Character" % name)
	
	_character.money_chaged.connect(func(new_money) -> void:
									_money_label.text = "Деньги: %s" % new_money)

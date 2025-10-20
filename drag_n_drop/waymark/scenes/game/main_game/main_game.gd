class_name MainGame extends Node2D


func _ready() -> void:
	Signals.start_new_turn.connect(_new_turn)
	# TODO make game to get start_resources that player have
	get_tree().get_first_node_in_group("character").set_money(100.0)
	
	GlobalUi.call_deferred("create_reources_panel")


func _new_turn(new_resources: Dictionary) -> void:
	var _character: Character = get_tree().get_first_node_in_group("character")
	
	for resource: String in new_resources.keys():
		_character.call("set_%s" % resource, new_resources[resource])
	
	for action: Action in get_tree().get_nodes_in_group("action"):
		action.queue_free()

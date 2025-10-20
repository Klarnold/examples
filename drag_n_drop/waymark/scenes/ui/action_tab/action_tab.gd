class_name ActionTab extends TabContainer


func _ready() -> void:
	
	for idx in get_child_count(): 
		set_tab_icon(idx, preload("uid://dgdmw42gxcagg"))
		set_tab_title(idx, "")

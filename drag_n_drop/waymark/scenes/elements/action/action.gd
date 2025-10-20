class_name Action extends TextureRect

## Area to detect action_cells
@onready var _action_area: Area2D = %ActionArea
@onready var _action_shape: CollisionShape2D = %ActionShape
## Var to concretely define state of an action as a node 
@onready var dragged: bool = false

## A variable used to determine position of an action in the game world.
## You shouldn't change in instances of other classes/ 
var _chained_pos: Vector2
## Determines position a starting dragging position for future developing.
var drag_st_pos: Vector2
## Temporary ActionCell instance to which chained action.
var action_cell: ActionCell
## Describes all necessary variable to be in any action.
var action_res: ActionRes


func _gui_input(event: InputEvent) -> void:
	# defines start of a drag
	if event.is_action_pressed("click"):
		dragged = true
		drag_st_pos = global_position - get_global_mouse_position()
		z_index += 1
	# defines an end of a drag
	elif event.is_action_released("click"):
		dragged = false
		if action_cell:
			action_cell.prepare_to_add_action(self)
		else:
			_free_itself()
		z_index -= 1


func _ready() -> void:
	assert(action_res != null, "%s has no action_res" % name)
	# visible texture of an Action instance
	texture = action_res.texture
	# forced name to more easily work with composition 
	name = GlobalsAction.ACTION_NAME
	# determines correct anchoring of this node
	size_flags_vertical = 4
	size_flags_horizontal = 4
	# necessary required to be make sure that global_position of this node
	# has been correctly set
	await get_tree().physics_frame
	await get_tree().physics_frame
	_action_area.global_position = global_position + size * 0.5
	_action_shape.shape.size = size
	_action_area.area_entered.connect(_on_area_entered)
	_action_area.area_exited.connect(_on_area_exited)
	_chained_pos = global_position
	action_cell = get_parent()
	set_deferred("visible", true)
	#print(global_position)


func _physics_process(delta: float) -> void:
	if dragged:
		global_position = get_global_mouse_position() + drag_st_pos


func _free_itself() -> void:
	queue_free()


func _on_area_entered(cell_area: Area2D) -> void:
	action_cell = cell_area.get_parent()


func _on_area_exited(cell_area: Area2D) -> void:
	action_cell = null

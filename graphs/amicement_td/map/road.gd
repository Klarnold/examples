class_name Road extends TileMapLayer


var astar_2d: AStar2D = AStar2D.new()
var map_rect: Rect2i


func _ready() -> void:
	map_rect = get_used_rect()
	_prepare_path_finding_graph()


func _prepare_path_finding_graph() -> void:
		for cell in get_used_cells():
			if astar_2d.has_point(_calculate_id(cell)):
				continue
			
			astar_2d.add_point(_calculate_id(cell), cell)
		
		for current_cell in get_used_cells():
			for direction: Vector2i in [Vector2.RIGHT, Vector2.LEFT, Vector2.UP, Vector2.DOWN]:
				var neighbour_cell = current_cell + direction
				var current_cell_id = _calculate_id(current_cell)
				var neighbour_cell_id = _calculate_id(neighbour_cell)
				if get_cell_source_id(neighbour_cell) == -1:
					continue
				
				if not astar_2d.are_points_connected(current_cell_id, neighbour_cell_id):
					astar_2d.connect_points(current_cell_id, neighbour_cell_id)


func find_path_to_point(start_point: Vector2, finish_point: Vector2):
	var start_point_id: int = _calculate_id(local_to_map(start_point))
	var finish_point_id: int = _calculate_id(local_to_map(finish_point))
	
	var path: PackedVector2Array = []
	for point in astar_2d.get_point_path(start_point_id, finish_point_id):
		path.append(map_to_local(point))
	
	return path


func _calculate_id(grid_pos: Vector2i) -> int:
	return grid_pos.x + (map_rect.size.x * grid_pos.y) + 10_000

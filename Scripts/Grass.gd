extends TileMap

func _ready():
	set_process_input(true)
	

func _input(event: InputEvent):
	pass
	###	ON MOUSE MOVEMENT
	#if event is InputEventMouseMotion:
	#	###	GET OVERLAYING TILE
	#	var mouse_pos = get_global_mouse_position()
	#	var tile_pos = world_to_map(mouse_pos)
	#	print(tile_pos)
	#	var tile = get_cellv(tile_pos)
	#	print(tile)
	#if event.is_action_pressed("hand_main_action"):
	#	var mouse_pos = get_global_mouse_position()
	#	var tile_pos = world_to_map(mouse_pos)
	#	set_cellv(tile_pos,0)

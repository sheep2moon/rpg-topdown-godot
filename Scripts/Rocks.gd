extends TileMap

var selected_tool = null

func _ready():
	set_process_input(true)
	

#func _input(event: InputEvent):
#	if PlayerData.inv_data["Inv"+ str(PlayerData.selected_tool)]["Item"]:
#		selected_tool = GameData.item_data[str(PlayerData.inv_data["Inv"+ str(PlayerData.selected_tool)]["Item"])]
#	else:
#		selected_tool = null
#	pass
#	print(selected_tool)
#	if event.is_action_pressed("hand_main_action") and selected_tool != null and selected_tool["PickPower"] > 5:
#		var mouse_pos = get_global_mouse_position()
#		var tile_pos = world_to_map(mouse_pos)
#		var tile = get_cellv(tile_pos)
#		if tile >= 3:
#			set_cellv(tile_pos,-1)
#		else:
#			set_cellv(tile_pos,tile+1)
		

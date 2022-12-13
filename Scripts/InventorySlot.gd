extends TextureRect


onready var UI = get_node("/root/World/UI")

func get_drag_data(_pos):
	var inv_slot = get_parent().get_name()
	var current_item_id = str(PlayerData.inv_data[inv_slot]["Item"])
	if current_item_id.is_valid_integer():
		var data = {}
		data["origin_node"] = self
		data["origin_panel"] = "Inventory"
		data["origin_item_id"] = current_item_id
		data["origin_equipment_slot"] = GameData.item_data[str(PlayerData.inv_data[inv_slot]["Item"])]["EquipmentSlot"]
		data["origin_stackable"] = GameData.item_data[str(PlayerData.inv_data[inv_slot]["Item"])]["Stackable"]
		data["origin_stack"] = PlayerData.inv_data[inv_slot]["Stack"]
		data["origin_texture"] = texture
	
		var drag_texture = TextureRect.new()
		drag_texture.expand = true
		drag_texture.texture = texture
		drag_texture.rect_size = (Vector2(32,32))
		
		var control = Control.new()
		control.add_child(drag_texture)
		drag_texture.rect_position = -0.5 * drag_texture.rect_size
		
		set_drag_preview(control)
		
		return data
	
func can_drop_data(_pos, data):
	var target_inv_slot = get_parent().get_name()
	var slot_item_id = PlayerData.inv_data[target_inv_slot]["Item"]
	if slot_item_id == null:
		data["target_item_id"] = null
		data["target_texture"] = null
		data["target_stack"] = null
		return true
	else: # item swap
		data["target_item_id"] = slot_item_id
		data["target_texture"] = texture
		data["target_stack"] = PlayerData.inv_data[target_inv_slot]["Stack"]
		if data["origin_panel"] == "CharacterSheet":
			if GameData.item_data[str(slot_item_id)]["EquipmentSlot"] == data["origin_equipment_slot"]:
				return true
			else:
				return false
		else: # move inside inventory
			return true
		
		
	
	
func drop_data(_pos, data):
	
	var target_inv_slot = get_parent().get_name()
	var origin_slot = data["origin_node"].get_parent().get_name()
	
	# Update data of origin
	if data["target_item_id"] == data["origin_item_id"] and data["origin_stackable"]:
		PlayerData.inv_data[origin_slot]["Item"] = null
		PlayerData.inv_data[origin_slot]["Stack"] = null
	elif data["origin_panel"] == "Inventory":
		PlayerData.inv_data[origin_slot]["Item"] = data["target_item_id"]
		PlayerData.inv_data[origin_slot]["Stack"] = data["target_stack"]
	else:
		PlayerData.equipment_data[origin_slot]["Item"] = data["target_item_id"]
		PlayerData.equipment_data[origin_slot]["Item"] = data["target_stack"]
	
	# Update texture and label of origin
	if data["target_item_id"] == data["origin_item_id"] and data["origin_stackable"]:
		data["origin_node"].texture = null
		data["origin_node"].get_node("../StackLabel").set_text("")
	elif data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		data["origin_node"].texture = load("res://Assets/Ui/EquipmentItems/" + origin_slot + ".png")
		data["origin_node"].get_parent().get_node("StackLabel").set_text("")
	else:
		data["origin_node"].texture = data["target_texture"]
		if data["target_stack"] != null and data["target_stack"] > 1:
			data["origin_node"].get_node("../StackLabel").set_text(str(data["target_stack"]))
		elif data["origin_panel"] == "Inventory":
			data["origin_node"].get_node("../StackLabel").set_text("")
			
	# Update texture label of target
	if data["target_item_id"] == data["origin_item_id"] and data["origin_stackable"]:
		var new_stack = data["target_stack"] + data["origin_stack"]
		PlayerData.inv_data[target_inv_slot]["Stack"] = new_stack
		get_node("../StackLabel").set_text(str(new_stack))	
	else:
		PlayerData.inv_data[target_inv_slot]["Item"] = data["origin_item_id"]
		texture = data["origin_texture"]
		PlayerData.inv_data[target_inv_slot]["Stack"] = data["origin_stack"]
		if data["origin_stack"] != null and data["origin_stack"] > 1:
			get_node("../StackLabel").set_text(str(data["origin_stack"]))
		else:
			get_node("../StackLabel").set_text("")
	
	SignalBus.emit_signal("on_selected_item_change",PlayerData.selected_tool)


















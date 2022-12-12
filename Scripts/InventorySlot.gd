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
		#data["origin_equipment_slot"] = inv_slot
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
		return true
	else: # item swap
		data["target_item_id"] = slot_item_id
		data["target_texture"] = texture
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
	
	if data["origin_panel"] == "Inventory":
		PlayerData.inv_data[origin_slot]["Item"] = data["target_item_id"]
	else:
		PlayerData.equipment_data[origin_slot] = data["target_item_id"]
	
	
	if data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		data["origin_node"].texture = load("res://Assets/Ui/EquipmentItems/" + origin_slot + ".png")
	else:
		data["origin_node"].texture = data["target_texture"]
	
	
	PlayerData.inv_data[target_inv_slot]["Item"] = data["origin_item_id"]
	texture = data["origin_texture"]
	var inv_slot_index = int(target_inv_slot.lstrip("Inv"))
	if inv_slot_index < 9:
		SignalBus.emit_signal("on_selected_item_change",inv_slot_index)


















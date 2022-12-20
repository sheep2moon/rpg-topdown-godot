extends TextureRect

func _ready():
	SignalBus.connect("on_equipment_item_change",self,"_On_Equipment_Item_Change")

func _On_Equipment_Item_Change(slot_name) -> void:
	# FOR NOW UPDATE ONLY STACK SIZE
	if slot_name == get_parent().get_name():
		var stack_size = PlayerData.equipment_data[slot_name]["Stack"]
		if stack_size == null:
			texture = load("res://Assets/Ui/EquipmentItems/" + slot_name + ".png")
			get_parent().get_node("StackLabel").set_text("")
		else:
			get_parent().get_node("StackLabel").set_text(str(stack_size))
		#var item_id = PlayerData.equipment_data[slot_name]["Item"]
		#texture = load("res://Assets/Items_Icons/"+ GameData.item_data[item_id]["Name"] +".png")
		
		
func get_drag_data(_pos):
	var equipment_slot = get_parent().get_name()
	if PlayerData.equipment_data[equipment_slot]["Item"] != null:
		var data = {}
		data["origin_node"] = self
		data["origin_panel"] = "CharacterSheet"
		data["origin_item_id"] = PlayerData.equipment_data[equipment_slot]["Item"]
		data["origin_equipment_slot"] = equipment_slot
		if equipment_slot == "Accessory":
			data["origin_stackable"] = true
			data["origin_stack"] =  PlayerData.equipment_data[equipment_slot]["Stack"]
		else:
			data["origin_stackable"] = false
			data["origin_stack"] =  1
			
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
	var target_equipment_slot = get_parent().get_name()
	if target_equipment_slot == data["origin_equipment_slot"]:
		if PlayerData.equipment_data[target_equipment_slot]["Item"] == null:
			data["target_item_id"] = null
			data["target_texture"] = null
			data["target_stack"] = null
		else:
			data["target_item_id"] = PlayerData.equipment_data[target_equipment_slot]["Item"]
			data["target_texture"] = texture
			if target_equipment_slot == "Accessory":
				data["target_stack"] = PlayerData.equipment_data[target_equipment_slot]["Stack"]
			else:
				data["target_stack"] = 1
		return true
	else:
		return false
	
	
func drop_data(_pos, data):
	var target_equipment_slot = get_parent().get_name()
	var origin_slot = data["origin_node"].get_parent().get_name()
	
	if data["origin_panel"] == "Inventory":
		PlayerData.inv_data[origin_slot]["Item"] = data["target_item_id"]
		# this applies only to accessory slot (ammunition)
		if data["origin_stackable"] and data["target_stack"] != null:
			data["origin_node"].get_parent().get_node("StackLabel").set_text(data["target_stack"])
		else:
			data["origin_node"].get_parent().get_node("StackLabel").set_text("")
	else:
		PlayerData.equipment_data[origin_slot] = data["target_item_id"]

	if data["origin_panel"] == "CharacterSheet" and data["target_item_id"] == null:
		print("TODO equpiment slot line 49")
		#print(origin_slot)
		#var default_texture = load("res://Assets/Ui/EquipmentItems/" + origin_slot + ".png")
		#print(default_texture)
		#data["origin_node"].texture = load("res://Assets/Ui/EquipmentItems/" + origin_slot + ".png")
	else:
		data["origin_node"].texture = data["target_texture"]
	
	print(data["origin_item_id"])
	print(PlayerData.equipment_data[target_equipment_slot]["Item"])
	PlayerData.equipment_data[target_equipment_slot]["Item"] = data["origin_item_id"]
	if data["origin_stackable"]:
		get_parent().get_node("StackLabel").set_text(str(data["origin_stack"]))
		PlayerData.equipment_data[target_equipment_slot]["Stack"] = data["origin_stack"]
	texture = data["origin_texture"]
	
	SignalBus.emit_signal("on_inventory_order_change")
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		
		

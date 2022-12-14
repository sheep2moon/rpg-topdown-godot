extends Node

var inv_data = {}
var equipment_data = {}
var inv_size = 28
var selected_tool = 1
var hp = 100
var energy = 100
var current_hp
var current_energy

func _ready():
	current_hp = hp
	current_energy = energy
	
	var inv_data_file = File.new()
	inv_data_file.open("user://inv_data_file.json",File.READ)
	var inv_data_json = JSON.parse(inv_data_file.get_as_text())
	inv_data_file.close()
	inv_data = inv_data_json.result
	print(inv_data)
	
	var eq_data_file = File.new()
	eq_data_file.open("user://equipment_data_file.json",File.READ)
	var eq_data_json = JSON.parse(eq_data_file.get_as_text())
	eq_data_file.close()
	equipment_data = eq_data_json.result


func save():
	var inv_data_file = File.new()
	inv_data_file.open("user://inv_data_file.json",File.WRITE)
	inv_data_file.store_string(JSON.print(inv_data))
	inv_data_file.close()
	
	var eq_data_file = File.new()
	eq_data_file.open("user://equipment_data_file.json",File.WRITE)
	eq_data_file.store_string(JSON.print(equipment_data))
	eq_data_file.close()


func add_to_inventory(item_id,quantity):
	print("Add to inv")
	print(item_id,quantity)
	var new_item_slot = null
	
	# If item is stackable looking for same item in inventory
	if GameData.item_data[item_id]["Stackable"]:
		for i in inv_data.keys():
		# Merge with existing
			if inv_data[i]["Item"] == item_id:
				inv_data[i]["Stack"] = quantity + inv_data[i]["Stack"]
				new_item_slot = i
				break
	# If not stackable, looking for first empty slot
	if new_item_slot == null:
		for i in inv_data.keys():
			if inv_data[i]["Item"] == null:
				inv_data[i] = {"Item": str(item_id),"Stack": quantity }
				new_item_slot = i
				break
				
	# If found place for item, return slot name and update slot
	if new_item_slot != null:
		var slot_index = int(new_item_slot.lstrip("Inv"))
		if slot_index == selected_tool:
			SignalBus.emit_signal("on_selected_item_change",slot_index)
		return new_item_slot
	# No empty slot
	return false

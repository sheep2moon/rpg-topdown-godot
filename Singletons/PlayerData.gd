extends Node

var inv_data = {}
var equipment_data = {}
var inv_lib = {}
var inv_size = 28
var selected_tool = 1
var hp = 100
var energy = 100
var current_hp
var current_energy
var coins = 0
var level = 1
var xp = 0

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


	# add inventory data to inv lib
	for i in inv_data.keys():
		var item_id = inv_data[i]["Item"]
		if item_id != null:
			var item_stack = inv_data[i]["Stack"]
			inv_lib[item_id] = item_stack
	
	print(inv_lib)
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
	var new_item_slot = null
	
	# If item is stackable looking for same item in inventory
	if GameData.item_data[item_id]["Stackable"]:
		for i in inv_data.keys():
		# Merge with existing
			if inv_data[i]["Item"] == item_id:
				inv_data[i]["Stack"] = quantity + inv_data[i]["Stack"]
				inv_lib[item_id] += quantity
				new_item_slot = i
				break
	# If not stackable, looking for first empty slot
	if new_item_slot == null:
		for i in inv_data.keys():
			if inv_data[i]["Item"] == null:
				inv_data[i] = {"Item": str(item_id),"Stack": quantity }
				inv_lib[item_id] = quantity
				new_item_slot = i
				break
				
	# If found place for item, return slot name and update slot
	if new_item_slot != null:
		SignalBus.emit_signal("on_user_inventory_change")
		var slot_index = int(new_item_slot.lstrip("Inv"))
		if slot_index == selected_tool:
			SignalBus.emit_signal("on_selected_item_change",slot_index)
		return new_item_slot
	# No empty slot
	return false

func remove_from_inventory(item_id,quantity):
	print(item_id,quantity)
	for i in inv_data.keys():
		if inv_data[i]["Item"] == item_id:
			if inv_data[i]["Stack"] > quantity:
				inv_data[i]["Stack"] -= quantity
				inv_lib[item_id] -= quantity
			elif inv_data[i]["Stack"] == quantity:
				inv_data[i] = {"Item": null,"Stack": null}
				inv_lib.erase(item_id)
			else:
				break
			SignalBus.emit_signal("on_user_inventory_change")
			return
			
		


func get_next_level_xp(level):
	return 128 * pow(level,2)

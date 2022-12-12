extends Node

var inv_data = {}
var equipment_data = {}
var inv_size = 28

func _ready():
	var inv_data_file = File.new()
	inv_data_file.open("user://inv_data_file.json",File.READ)
	var inv_data_json = JSON.parse(inv_data_file.get_as_text())
	inv_data_file.close()
	inv_data = inv_data_json.result
	
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


func add_to_inventory(item_id):
	# adding to first free slot
	var new_item_slot
	for i in inv_data.keys():
		if not inv_data[i]["Item"]:
			inv_data[i] = {"Item": item_id }
			print(i,"added to <-")
			new_item_slot = i
			return new_item_slot
	return false

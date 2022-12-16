extends Node

var item_data = {}
var buildings_data = {}

func _ready():
	var item_data_file = File.new()
	item_data_file.open("res://Data/ItemData.json",File.READ)
	var item_data_json = JSON.parse(item_data_file.get_as_text())
	item_data_file.close()
	item_data = item_data_json.result
	
	var buildings_data_file = File.new()
	buildings_data_file.open("res://Data/BuildingsData.json",File.READ)
	var buildings_data_json = JSON.parse(buildings_data_file.get_as_text())
	buildings_data_file.close()
	buildings_data = buildings_data_json.result

func get_icon_path_by_item_id(item_id):
	print(item_id)
	var item_name = GameData.item_data[item_id]["Name"]
	return load("res://Assets/Items_Icons/" + item_name + ".png")

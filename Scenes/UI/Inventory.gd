extends Control


const template_inv_slot = preload("res://Scenes/UI/InventorySlot.tscn")
onready var grid_container = $Background/M/V/ScrollContainer/GridContainer


func _ready():
	if PlayerData.inv_data:	
		var inventory_keys: Array = PlayerData.inv_data.keys()
		for i in inventory_keys.slice(8,-1):
			var inv_slot_new = template_inv_slot.instance()
			inv_slot_new.set_name(i)
			
			if PlayerData.inv_data[i]["Item"]:
				var item_name = GameData.item_data[str(PlayerData.inv_data[i]["Item"])]["Name"]
				var icon_texture = load("res://Assets/Items_Icons/" + item_name + ".png")
				inv_slot_new.get_node("Icon").set_texture(icon_texture)
			print(inv_slot_new.name)
			grid_container.add_child(inv_slot_new,true)

func update_inventory_slot(slot_name):
	var item_name = GameData.item_data[str(PlayerData.inv_data[slot_name]["Item"])]["Name"]
	var icon_texture = load("res://Assets/Items_Icons/" + item_name + ".png")
	#var inv_slot_index = int(slot_name.lstrip("Inv"))

	grid_container.get_node(slot_name).get_node("Icon").set_texture(icon_texture)

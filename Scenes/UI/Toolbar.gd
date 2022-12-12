extends Control

const template_inv_slot = preload("res://Scenes/UI/InventorySlot.tscn")
onready var toolbar_container = $SlotsContainer

# tool range 1 - 8
var selected_tool = 1

func _ready():
	if PlayerData.inv_data:	
		var inventory_keys: Array = PlayerData.inv_data.keys()
		for i in inventory_keys.slice(0,7):
			var inv_slot_new = template_inv_slot.instance()
			if i == "Inv1":
				inv_slot_new.get_node("Active").visible = true
			if PlayerData.inv_data[i]["Item"]:
				var item_name = GameData.item_data[str(PlayerData.inv_data[i]["Item"])]["Name"]
				var icon_texture = load("res://Assets/Items_Icons/" + item_name + ".png")
				inv_slot_new.get_node("Icon").set_texture(icon_texture)
			toolbar_container.add_child(inv_slot_new,true)
		
func _unhandled_key_input(event):
	if event.pressed:
		match event.scancode:
			KEY_1:
				select_tool(1)
			KEY_2:
				select_tool(2)
			KEY_3:
				select_tool(3)
			KEY_4:
				select_tool(4)
			KEY_5:
				select_tool(5)
			KEY_6:
				select_tool(6)
			KEY_7:
				select_tool(7)
			KEY_8:
				select_tool(8)
		

func select_tool(idx):
	var prev_selected = selected_tool
	selected_tool = idx
	toolbar_container.get_child(prev_selected-1).get_node("Active").visible = false
	toolbar_container.get_child(idx-1).get_node("Active").visible = true
	SignalBus.emit_signal("on_selected_item_change",idx)

func update_inventory_slot(slot_name):
	var item_name = GameData.item_data[str(PlayerData.inv_data[slot_name]["Item"])]["Name"]
	var icon_texture = load("res://Assets/Items_Icons/" + item_name + ".png")
	var inv_slot_index = int(slot_name.lstrip("Inv"))
	toolbar_container.get_child(inv_slot_index-1).get_node("Icon").set_texture(icon_texture)




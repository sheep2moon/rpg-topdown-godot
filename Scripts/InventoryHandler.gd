extends Control
class_name InvenoryHandler

const template_inv_slot = preload("res://Scenes/UI/InventorySlot.tscn")
func create_inv_slot(slot_name):
	var inv_slot_new = template_inv_slot.instance()
	inv_slot_new.set_name(slot_name)
	var item_slot = PlayerData.inv_data[slot_name]
	if item_slot["Item"]:
		var item_name = GameData.item_data[str(item_slot["Item"])]["Name"]
		var item_stack = item_slot["Stack"]
		if item_stack and item_stack > 1:
			inv_slot_new.get_node("StackLabel").set_text(str(item_stack))
		var icon_texture = load("res://Assets/Items_Icons/" + item_name + ".png")
		inv_slot_new.get_node("Icon").set_texture(icon_texture)
	return inv_slot_new

func update_slot(slot_name,container):
	var item_name = GameData.item_data[str(PlayerData.inv_data[slot_name]["Item"])]["Name"]
	var item_stack = PlayerData.inv_data[slot_name]["Stack"]
	var icon_texture = load("res://Assets/Items_Icons/" + item_name + ".png")
	container.get_node(slot_name).get_node("Icon").set_texture(icon_texture)
	if item_stack > 1:
		container.get_node(slot_name).get_node("StackLabel").set_text(str(item_stack))


extends Control

onready var EquipmentSlots = $M/LeftEquip

func _ready():
	for i in EquipmentSlots.get_child_count():
		var slot_name = EquipmentSlots.get_child(i).get_name()
		if PlayerData.equipment_data[slot_name]["Item"]:
			var slot_node = EquipmentSlots.get_child(i)
			if slot_name == "Accessory" and PlayerData.equipment_data[slot_name]["Stack"] != null:
				slot_node.get_node("StackLabel").set_text(str(PlayerData.equipment_data[slot_name]["Stack"]))
			var equipment_name = GameData.item_data[str(PlayerData.equipment_data[slot_name]["Item"])]["Name"]
			var texture = load("res://Assets/Items_Icons/" + equipment_name + ".png")
			slot_node.get_node("Icon").texture = texture

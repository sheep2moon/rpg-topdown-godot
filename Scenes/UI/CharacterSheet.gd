extends Control

onready var EquipmentSlots = $M/LeftEquip

func _ready():
	for i in EquipmentSlots.get_child_count():
		var slot_name = EquipmentSlots.get_child(i).get_name()
		if PlayerData.equipment_data[slot_name]:
			var equipment_name = GameData.item_data[str(PlayerData.equipment_data[slot_name])]["Name"]
			var texture = load("res://Assets/Items_Icons/" + equipment_name + ".png")
			EquipmentSlots.get_child(i).get_child(0).texture = texture

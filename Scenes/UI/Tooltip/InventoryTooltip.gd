extends Tooltip


onready var name_label = $Frame/M/V/H/NameLabel

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		custom_hide()

func _ready():
	print(get_parent().get_name())
	var item_id = PlayerData.inv_data[get_parent().get_name()]["Item"]
	if item_id != null:
		var item_data = GameData.item_data[item_id]
		name_label.set_text(item_data["Name"])
	

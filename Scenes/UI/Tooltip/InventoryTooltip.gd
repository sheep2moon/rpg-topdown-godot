extends Tooltip

onready var stat_row = preload("res://Scenes/UI/Tooltip/StatRow.tscn")
onready var name_label = $Frame/M/V/H/NameLabel
onready var stat_container = $Frame/M/V/V

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		custom_hide()

func _ready():
	#SignalBus.connect("on_inventory_order_change",self,"update_content")
	var item_id = PlayerData.inv_data[get_parent().get_name()]["Item"]
	if item_id != null:
		var item_data = GameData.item_data[item_id]
		name_label.set_text(item_data["Name"])
		if item_data["Type"] == "Melee":
			var icon = GameData.get_icon_path_by_item_id(item_id)
			add_stat("Attack",str(item_data["Attack"]),icon)
			add_stat("Attack Speed",str(item_data["AttackSpeed"]))
	else:
		disabled = true

func update_content():
	var item_id = PlayerData.inv_data[get_parent().get_name()]["Item"]
	print(item_id,get_parent().get_name())
	for children in stat_container.get_children():
		children.queue_free()
	
	#if stat_container.get_child_count() > 1:
	#	for i in range(1,stat_container.get_child_count()-1):
	#		stat_container.get_child(i).queue_free()
	if item_id != null:
		disabled = false
		var item_data = GameData.item_data[item_id]
		name_label.set_text(item_data["Name"])
		#add_stat("",item_data["Name"])
		if item_data["Type"] == "Melee":
			var icon = GameData.get_icon_path_by_item_id(item_id)
			add_stat("Attack",str(item_data["Attack"]),icon)
			add_stat("Attack Speed",str(item_data["AttackSpeed"]))
	else:
		print("disabled !",item_id)
		disabled = true	
	
func add_stat(name,value,icon = ""):
	var stat_instance = stat_row.instance()
	if icon:
		stat_instance.get_node("Icon").set_texture(icon)
	stat_instance.get_node("Name").set_text(name)
	stat_instance.get_node("Value").set_text(value)
	stat_container.add_child(stat_instance)

extends Tooltip

onready var new_material_scene = preload("res://Scenes/UI/Tooltip/BuildItemMaterial.tscn")

onready var material_list_container = $Frame/M/V


func _input(event):
	if event.is_action_pressed("toggle_building_menu"):
		custom_hide()




func init_tooltip_content(materials: Dictionary):
	$Frame.rect_size.y = 26 + materials.size() * 20
	for i in materials.keys():
		var material_instance = new_material_scene.instance()
		var item_name = GameData.item_data[i]["Name"]
		var icon_texture = load("res://Assets/Items_Icons/" + item_name + ".png")
		$Frame/M/V/NameLabel.set_text(get_parent().get_name())
		material_instance.name = item_name
		material_instance.get_node("Icon").set_texture(icon_texture)
		var name_node = material_instance.get_node("Name")
		var quantity_node = material_instance.get_node("Quantity")
		if materials[i]["Owned"]:
			name_node.set("custom_colors/font_color",Color("eeeeee"))
			quantity_node.set("custom_colors/font_color",Color("eeeeee"))
		else:
			name_node.set("custom_colors/font_color",Color("913e3e"))
			quantity_node.set("custom_colors/font_color",Color("913e3e"))
			
		name_node.set_text(item_name)
		quantity_node.set_text(str(materials[i]["Quantity"]))
		material_list_container.add_child(material_instance)
		



func update_tooltip_content(materials: Dictionary):
	for i in materials.keys():
		var item_name = GameData.item_data[i]["Name"]
		var instance_node = material_list_container.get_node(item_name)
		var name_node = instance_node.get_node("Name")
		var quantity_node = instance_node.get_node("Quantity")
		if materials[i]["Owned"]:
			name_node.set("custom_colors/font_color",Color("eeeeee"))
			quantity_node.set("custom_colors/font_color",Color("eeeeee"))
		else:
			name_node.set("custom_colors/font_color",Color("913e3e"))
			quantity_node.set("custom_colors/font_color",Color("913e3e"))






















































































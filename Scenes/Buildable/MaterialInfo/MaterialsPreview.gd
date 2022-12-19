extends VBoxContainer

var materials = {}
var material_scene = preload("res://Scenes/Buildable/MaterialInfo/SingleMaterial.tscn")
	
func _ready():
	visible = false
	get_parent().connect("mouse_over",self,"_on_mouse_over")
	rect_position += get_global_mouse_position() + Vector2(5,5)
	for i in materials.keys():
		var material_data = GameData.item_data[i]
		var new_material = material_scene.instance()
		new_material.get_node("NameLabel").set_text(material_data["Name"])
		new_material.get_node("QuantityLabel").set_text("0/" + str(materials[i]))
		new_material.get_node("Icon").texture = GameData.get_icon_path_by_item_id(i)
		add_child(new_material)

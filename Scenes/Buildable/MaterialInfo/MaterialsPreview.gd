extends VBoxContainer

var materials = {}
var material_scene = preload("res://Scenes/Buildable/MaterialInfo/SingleMaterial.tscn")
	
func _ready():
	
	rect_position += Vector2(-45,5)
	for i in materials.keys():
		var material_data = GameData.item_data[i]
		var new_material = material_scene.instance()
		new_material.get_node("NameLabel").set_text(material_data["Name"])
		new_material.get_node("QuantityLabel").set_text("0/" + str(materials[i]))
		new_material.get_node("Icon").texture = GameData.get_icon_path_by_item_id(i)
		add_child(new_material)

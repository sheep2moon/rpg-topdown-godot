extends TextureButton

onready var monochrome_shader = preload("res://Shaders/Monochrome.gdshader")

onready var icon: TextureRect = $V/Icon
var needed_materials = {}
var can_build = false

func _on_BuildMenuSlot_pressed():
	if can_build():
		$Tooltip.custom_hide()
		SignalBus.emit_signal("on_building_menu_select",name)
	
func _ready():
	icon.material = ShaderMaterial.new()
	SignalBus.connect("on_user_inventory_change",self,"_on_user_inventory_change")
	validate_if_user_own_materials()
	$Tooltip.init_tooltip_content(needed_materials)
	

func _on_user_inventory_change():
	validate_if_user_own_materials()
	$Tooltip.update_tooltip_content(needed_materials)

func validate_if_user_own_materials():
	var raw_materials = GameData.buildings_data[name]["Materials"]
	var display_materials = {}
	for m in raw_materials.keys():
			display_materials[m] = {"Quantity": raw_materials[m],"Owned": false}
			for l in PlayerData.inv_lib.keys():
				if l == m && PlayerData.inv_lib[l] >= raw_materials[m]:
					display_materials[m]["Owned"] = true
					break
	needed_materials = display_materials
	can_build = can_build()
	if can_build:
		icon.material.shader = null
	else:
		icon.material.shader = monochrome_shader

func can_build():
	for i in needed_materials.keys():
		if needed_materials[i]["Owned"] == false:
			return false
	return true

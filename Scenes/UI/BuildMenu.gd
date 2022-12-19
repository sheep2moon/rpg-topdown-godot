extends Control

const build_frame = preload("res://Scenes/UI/BuildMenuSlot.tscn")
onready var grid_container = $Bg/Margin/V/Scroll/Grid



func _ready():
	
	# i - building name
	for i in GameData.buildings_data.keys():
		#var display_materials = {}
		#var building_materials = GameData.buildings_data[i]["Materials"]
		# m - material id
		#for m in building_materials.keys():
		#	display_materials[m] = {"Quantity": building_materials[m],"Owned": false}
			#display_materials[m]["Stack"] = building_materials[m]
			#display_materials[m]["Owned"] = false
			# l - item id
		#	for l in PlayerData.inv_lib.keys():
		#		if l == m && PlayerData.inv_lib[l] > building_materials[m]:
		#			display_materials[m]["Owned"] = true
		#			break		
		#print(display_materials)
		var new_slot = build_frame.instance()
		new_slot.name = i
		#new_slot.materials = display_materials
		new_slot.get_node("V/Icon").texture = load("res://Assets/BuildingsMenu/" + i + ".png")
		new_slot.get_node("V/Label").set_text(i)
		grid_container.add_child(new_slot)

func update_buildings():
	# i - building name
	for i in GameData.buildings_data.keys():
		var display_materials = {}
		var building_materials = GameData.buildings_data[i]["Materials"]
		for m in building_materials.keys():
			display_materials[m] = {"Quantity": building_materials[m],"Owned": false}
			for l in PlayerData.inv_lib.keys():
				if l == m && PlayerData.inv_lib[l] > building_materials[m]:
					display_materials[m]["Owned"] = true
					break		
		#grid_container.get_node(i).materials = 
		

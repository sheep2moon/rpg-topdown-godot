extends Control

const build_frame = preload("res://Scenes/UI/BuildMenuSlot.tscn")
onready var grid_container = $Bg/Margin/V/Scroll/Grid



func _ready():
	
	for i in GameData.buildings_data.keys():
		print(i)
		var new_slot = build_frame.instance()
		new_slot.name = i
		new_slot.get_node("V/Icon").texture = load("res://Assets/BuildingsMenu/" + i + ".png")
		new_slot.get_node("V/Label").set_text(i)
		grid_container.add_child(new_slot)

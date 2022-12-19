extends StaticBody2D
class_name Building

enum STATE {PREVIEW,PLAN,BUILDED}

onready var collision: CollisionShape2D = $CollisionShape2D
onready var can_build_area: Area2D = $Area2D

var can_build: bool = true
var build_name: String 
var default_modulate
var state = STATE.PREVIEW
#var materials

func _ready():
	default_modulate = modulate
	modulate.a = 0.5
	collision.disabled = true
	
	
func _process(delta):

	
	if state == STATE.PREVIEW:
		if not can_build_area.get_overlapping_bodies().empty():
			can_build = false
		else:
			can_build = true
		global_position = get_global_mouse_position()
		if can_build:
			modulate.r = 0
		else:
			modulate.r = 255
	
	
func _input(event):
	# BUILD
	if Input.is_action_just_pressed("hand_main_action") and state == STATE.PREVIEW and can_build:
		modulate = default_modulate
		collision.disabled = false
		can_build_area.get_node("CollisionShape2D").disabled = true	
		state = STATE.BUILDED	
		for i in GameData.buildings_data[build_name]["Materials"].keys():
			PlayerData.remove_from_inventory(i,GameData.buildings_data[build_name]["Materials"][i])

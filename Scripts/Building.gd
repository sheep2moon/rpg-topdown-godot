extends StaticBody2D
class_name Building

onready var collision: CollisionShape2D = $CollisionShape2D
onready var can_build_area: Area2D = $Area2D
onready var materials_preview_scene = preload("res://Scenes/Buildable/MaterialInfo/MaterialsPreview.tscn")

var build_name: String = ""
var builded: bool = false
var can_build: bool = true
var default_modulate

func _ready():
	connect("mouse_entered",self,"_on_mouse_entered")
	connect("mouse_exited",self,"_on_mouse_extied")
	default_modulate = modulate
	can_build_area.connect("body_entered",self,"_on_body_entered")
	can_build_area.connect("body_exited",self,"_on_body_exited")
	modulate.a = 0.5
	collision.disabled = true
	
	
func _process(delta):
	
	
	if not builded:
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
	if Input.is_action_just_pressed("hand_main_action") and not builded and can_build:
		var materials_preview_instance = materials_preview_scene.instance()
		materials_preview_instance.materials = GameData.buildings_data[build_name]["Materials"]
		add_child(materials_preview_instance)
		builded = true
		modulate = default_modulate
		collision.disabled = false
		can_build_area.get_node("CollisionShape2D").disabled = true
		can_build_area.disconnect("body_entered",self,"_on_body_entered")		
		can_build_area.disconnect("body_exited",self,"_on_body_exited")		
func _on_body_entered():
	can_build = false
	print("body_entered")

func _on_body_exited():
	can_build = true

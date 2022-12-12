extends Node2D

onready var pickable_item_scene = preload("res://Scenes/PickableItem.tscn")


func _ready():
	SignalBus.connect("on_drop_items",self,"on_drop_items")

func on_drop_items(position,item_id,quantity):
	var item_texture = GameData.get_icon_path_by_item_id(item_id)
	
	for i in range(quantity):
		var item_instance = pickable_item_scene.instance()
		item_instance.init(item_id,item_texture,position)
		add_child(item_instance)

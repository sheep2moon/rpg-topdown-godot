extends Node2D

onready var pickable_item_scene = preload("res://Scenes/PickableItem.tscn")


func _ready():
	SignalBus.connect("on_drop_items",self,"on_drop_items")

func on_drop_items(position,item_id,quantity):
	var item_texture = GameData.get_icon_path_by_item_id(item_id)
	if quantity < 20:
		for i in range(quantity):
			var item_instance = pickable_item_scene.instance()
			item_instance.init(item_id,item_texture,Vector2(position.x + rand_range(-15,15),position.y + rand_range(-15,15)),1)
			call_deferred("add_child",item_instance)
	else:
		var item_instance = pickable_item_scene.instance()
		item_instance.init(item_id,item_texture,position,quantity)
		call_deferred("add_child",item_instance)
		#add_child(item_instance)

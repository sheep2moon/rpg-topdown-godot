extends Area2D

export var item_id: int
export var texture: Texture

func _ready():
	pass

func init(_item_id,_texture,position):
	item_id = int(_item_id)
	$Sprite.texture = _texture
	global_position = position



func _on_PickableItem_body_entered(body):
	if body.has_method("pick_up_item"):
		body.pick_up_item(item_id)
		queue_free()

extends Area2D

export var item_id: String
export var texture: Texture
export var quantity: int = 1

func _ready():
	$Tween.interpolate_property(self,"global_position",global_position,Vector2(global_position.x + rand_range(-15,15),global_position.y + rand_range(-15,15)),0.5,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	$Tween.start()
	if texture:
		$Sprite.texture = texture



func init(_itemId,_texture,_position,_quantity):
	item_id = _itemId
	$Sprite.texture = _texture
	global_position = _position
	quantity = _quantity



func _on_PickableItem_body_entered(body):
	if body.name == "Player":
		SignalBus.emit_signal("on_player_enter_pickup_item",item_id,quantity,self)


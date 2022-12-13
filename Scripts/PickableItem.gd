extends Area2D

export var item_id: String
export var texture: Texture
export var quantity: int = 1

func _ready():
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


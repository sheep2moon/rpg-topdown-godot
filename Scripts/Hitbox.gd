extends Area2D
class_name Hitbox

export var damage: int = 1
export var knockback_power: int = 10
export var knockback_direction: Vector2 = Vector2.ZERO

func _init():
	connect("area_entered",self,"_on_area_entered")
	

func _on_area_entered(area: Area2D):
	if area.has_method("take_damage"):
		area.take_damage(damage,knockback_direction,knockback_power)

extends Area2D
class_name Hurtbox

const HIT_EFFECT = preload("res://Scenes/Animations/HitEffect.tscn")
const DMG_LABEL = preload("res://Scenes/AmountLabel.tscn")



onready var parent = get_parent()


func take_damage(dmg,direction,force):
	parent.life -= dmg
	if parent.life <= 0:
		parent.die()
	parent._velocity += direction * force
	var hit_effect: Sprite = HIT_EFFECT.instance()
	var dmg_label: Position2D = DMG_LABEL.instance()
	dmg_label.amount = dmg
	parent.add_child(dmg_label)
	parent.add_child(hit_effect)
	

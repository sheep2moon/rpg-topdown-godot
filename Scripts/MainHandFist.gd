extends Node2D
class_name MainHandFist

onready var hitbox = $Hinge/Sprite/Hitbox
onready var sprite = $Hinge/Sprite
#onready var sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var can_swing = true


#var text = load("res://Assets/Items_Icons/Blacksteel Sword.png")
#func _ready():
#	sprite.texture = text
func _ready():
	animation_player.connect("animation_finished",self,"on_animation_ended")

func move() -> void:
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	rotation = mouse_direction.angle()
	hitbox.knockback_direction = mouse_direction
	if scale.y == 1 and mouse_direction.x < 0:
		scale.y = -1
	elif scale.y == -1 and mouse_direction.x > 0:
		scale.y = 1
	

	


func swing() -> void:
	move()
	animation_player.play("Swing")

func on_animation_ended(anim_name) -> void:
	pass

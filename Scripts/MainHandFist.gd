extends Node2D
class_name MainHandFist

#onready var hitbox = $Hinge/Sprite/Hitbox
onready var sprite = $Hinge/Sprite
#onready var sprite = $Sprite
onready var animation_player: AnimationPlayer = $AnimationPlayer
onready var can_swing = true
var main_action_speed: float = 1.0

func get_input():
	if Input.is_action_pressed("hand_main_action"):
		take_main_action()
	

func _ready():
	animation_player.connect("animation_finished",self,"on_animation_ended")

func move() -> void:
	var mouse_direction: Vector2 = get_mouse_direction() 
	rotation = mouse_direction.angle()
	#hitbox.knockback_direction = mouse_direction
	if scale.y == 1 and mouse_direction.x < 0:
		scale.y = -1
	elif scale.y == -1 and mouse_direction.x > 0:
		scale.y = 1
	
func get_mouse_direction() -> Vector2:
	return (get_global_mouse_position() - global_position).normalized()
	


func take_main_action() -> void:
	move()
	animation_player.play("Swing")

func on_animation_ended(anim_name) -> void:
	pass

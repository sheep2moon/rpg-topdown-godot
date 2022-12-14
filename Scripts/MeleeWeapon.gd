extends MainHandFist

var ready_for_attack := true
onready var hitbox = $Hinge/Sprite/Hitbox



func on_animation_ended(anim_name):
	print(anim_name)
	if anim_name == "Swing":
		ready_for_attack = true
	
func take_main_action():
	if ready_for_attack:
		ready_for_attack = false
		move()
		hitbox.knockback_direction = get_mouse_direction()
		animation_player.play("Swing")

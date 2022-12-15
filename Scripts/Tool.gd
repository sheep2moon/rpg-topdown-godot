extends MainHandFist

var ready_for_use := true
var tool_type: String
onready var timer = $Timer
onready var hitbox = $Hinge/Sprite/Hitbox



func on_animation_ended(anim_name):
	if anim_name == "Swing":
		ready_for_use = true
		#timer.start()
		
	
func take_main_action():
	if ready_for_use:
		ready_for_use = false
		move()
		animation_player.play("Swing")


func _on_Timer_timeout():
	ready_for_use = true

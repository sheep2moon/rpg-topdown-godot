extends StateMachine



func _init() -> void:
	add_state("idle")
	add_state("attack")
	add_state("move")
	add_state("dead")
	add_state("run")
	

func _ready():
	set_state(states.idle)
	


func _state_logic(delta):
	#print(parent.velocity)
	match state:
		states.idle:
			parent.get_input()
		states.move:
			parent.get_input()


func _get_transition(delta):
	match state:
		states.idle:
			if abs(parent._velocity.x) > 1 or abs(parent._velocity.y) > 1:
				
				return states.move
		states.move:
			if abs(parent._velocity.x) < 1 and abs(parent._velocity.y) < 1:
				return states.idle

		
		
	return null

func _enter_state(new_state,old_state):
	match state:
		states.idle:
			pass
			#animation_player.play("idle")
		states.move:
			pass
			#animation_player.play("move")

		
	
func _exit_state(old_state,new_state):
	pass


func _on_AnimationPlayer_animation_finished(anim_name):
	match state:
		states.attack:
			set_state(states.idle)

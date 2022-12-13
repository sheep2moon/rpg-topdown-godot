extends StateMachine
class_name EnemySM
#onready var _timer: Timer = get_node("./Timer")


func _ready():
	get_parent().get_node("AnimationPlayer").connect("animation_finished",self,"_on_AnimationPlayer_animation_finished")
	add_state("idle")
	add_state("attack")
	add_state("chase_player")
	add_state("return_spawn")
	add_state("die")
	add_state("get_damage")
	call_deferred("set_state",states.idle)
	
func _state_logic(delta):
	match state:
		states.chase_player:
			parent.chase_player(delta)
			parent._animations.play("Move")
		states.return_spawn:
			parent.return_spawn()
			parent._animations.play("Move")

func _get_transition(delta):
	match state:
		states.idle:
			if parent.can_attack():
				return states.attack
			if parent.should_chase():
				return states.chase_player
			if parent.should_return_spawn():
				return states.return_spawn
			
		states.attack:
			pass
		states.chase_player:
			if not parent.should_chase():
				return states.idle
			if parent.can_attack():
				return states.attack
		states.return_spawn:
			if not parent.should_return_spawn():
				return states.idle
		states.get_damage:
			if parent.life <= 0:
				return states.die

func _enter_state(new_state,old_state):
	match new_state:
		states.die:
			parent._animations.play("Dead")
			$"../Collision".set_deferred("disabled",true)
			$"../Hurtbox/HurtShape".set_deferred("disabled",true)
			$"../Hitbox/CollisionShape2D".set_deferred("disabled",true)
			$"../Sprite".z_index = -3
			yield(get_tree().create_timer(60.0),"timeout")
			parent.queue_free()
		states.attack:
			parent.attack()
			parent._animations.play("Attack")
		states.idle:
			parent._velocity = Vector2.ZERO
			parent._animations.play("Idle")
		
			
			
	
func _exit_state(old_state,new_state):
	pass
	

func _on_AnimationPlayer_animation_finished(anim_name):
	match state:
		states.attack:
			set_state(states.idle)
			#parent.queue_free()	





extends MainHandFist

#onready var timer = $Timer
onready var projectile = load("res://Scenes/Main_Hand/Projectile.tscn")
onready var projectile_start_point = $Hinge/ShotPoint
var can_shot = true
var is_bow_drawn = false
var playing_backwards = false



func get_input():
	move()
	if Input.is_action_pressed("hand_main_action") and not animation_player.is_playing() and can_shot:
		animation_player.play("Pull")
		can_shot = false
		#playing_backwards = false
	if Input.is_action_just_released("hand_main_action"):
		var shot_power = animation_player.current_animation_position
		if shot_power > 0.4:
			take_a_shot(shot_power)
			SignalBus.emit_signal("shake_camera",0.1,6,6)
		animation_player.playback_speed = shot_power * 10
		animation_player.play_backwards()
		playing_backwards = true
		#take_main_action(pull_power)
	#elif Input.is_action_just_released("hand_main_action") and not shot_ready:
	#	animation_player.play_backwards()
	#	cancel_pull = true
#func take_main_action():
	#move()
	#var ammunition_id = PlayerData.equipment_data["Accessory"]["Item"]
	#if ammunition_id != null and PlayerData.equipment_data["Accessory"]["Stack"] > 0:
	#	animation_player.play("Release")
		#can_shot = false
		
		
func take_a_shot(shot_power):
	var ammunition_id = PlayerData.equipment_data["Accessory"]["Item"]
	print(shot_power)
	print(main_action_speed)
	if ammunition_id != null and PlayerData.equipment_data["Accessory"]["Stack"] > 0:
		if PlayerData.equipment_data["Accessory"]["Stack"] == 1:
			PlayerData.equipment_data["Accessory"] = {"Item": null,"Stack": null}
		else:
			PlayerData.equipment_data["Accessory"]["Stack"] -= 1
				
		SignalBus.emit_signal("on_equipment_item_change","Accessory")
		var projectile_scene = projectile.instance()
		projectile_scene.get_node("Sprite").set_texture(load("res://Assets/Items_Icons/" + GameData.item_data[ammunition_id]["Name"] + ".png"))
		projectile_scene.damage = float(GameData.item_data[ammunition_id]["Attack"]) * shot_power
		projectile_scene.speed = shot_power * 100
		var direction = projectile_start_point.global_position - global_position
		print(direction)
		SignalBus.emit_signal("launch_projectile",projectile_scene,projectile_start_point.global_position, direction)
	
func on_animation_ended(anim_name) -> void:
	if anim_name == "Pull":
		if playing_backwards:
			playing_backwards = false
			can_shot = true
		else:
			is_bow_drawn = true
		animation_player.playback_speed = main_action_speed
	#if anim_name == "Release":
	#	launch_projectile()
	#	shot_ready = false


#func _on_Timer_timeout():
	#can_shot = true

extends MainHandFist

var ready_for_attack := true

#onready var sprite = get_node("Sprite")

func attack(angle):
	pass
	#if not ready_for_attack:
	#	return
	#ready_for_attack = false
	#attack_state = AttackInputStates.WAITING
	#rotation = angle + PI
	#animations.play("Attack_Swing")
	# var weaponName = GameData.item_data[str(PlayerData.inv_data[i]["Item"])]["Name"]


func update_texture(weapon_name):
	print(weapon_name)
	#var texture = load("res://Assets/Items_Icons/" + weapon_name + ".png")
	#print(texture)
	print(sprite)
	sprite.texture = load("res://Assets/Items_Icons/" + weapon_name + ".png")


func _on_WeaponAnimations_animation_finished(anim_name):
	ready_for_attack = true
	

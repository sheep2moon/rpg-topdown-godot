extends Node2D
class_name MainHand

var melee_weapon_scene = load("res://Scenes/Main_Hand/Melee_Weapon.tscn")
var carried_item_scene = load("res://Scenes/Main_Hand/Carried_Item.tscn")
var bare_hands_scene = load("res://Scenes/Main_Hand/Bare_Hands.tscn")
var distance_weapon_scene = load("res://Scenes/Main_Hand/DistanceWeapon.tscn")

var ready_for_attack = true
onready var hand_pivot = get_node("HandPivot")





func _ready():
	select_item(1)
	SignalBus.connect("on_selected_item_change",self,"select_item")
	
func make_action(angle):
	# temporary just swing
	hand_pivot.get_child(0).take_main_action()
	#if hand_pivot.get_child(0).get_name() == "DistanceWeapon":
	#	hand_pivot.get_child(0).shot()
		
	
func select_item(new_item_inv_index):
	print("Select item")
	var item_id = PlayerData.inv_data["Inv"+str(new_item_inv_index)]["Item"]
	if hand_pivot.get_child_count() > 0:
		print(hand_pivot.get_child_count())
		print("delete hand child")
		hand_pivot.get_child(0).queue_free()
	
	print(item_id)
	# attach weapon
	if item_id != null and GameData.item_data[str(item_id)]["Category"] == "Weapon":
		match GameData.item_data[str(item_id)]["Type"]:
			"Melee":
				print("ATTACH MELLEE")
				var new_hand_instance = melee_weapon_scene.instance()
				new_hand_instance.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + GameData.item_data[str(item_id)]["Name"] + ".png")
				new_hand_instance.get_node("AnimationPlayer").playback_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
				new_hand_instance.get_node("Hinge/Sprite/Hitbox").damage = float(GameData.item_data[str(item_id)]["Attack"])
				new_hand_instance.main_action_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
				hand_pivot.add_child(new_hand_instance)
			"Bow":
				print("ATTACH BOW")
				var new_hand_instance = distance_weapon_scene.instance()
				new_hand_instance.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + GameData.item_data[str(item_id)]["Name"] + ".png")
				new_hand_instance.get_node("AnimationPlayer").playback_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
				new_hand_instance.main_action_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
				hand_pivot.add_child(new_hand_instance)
			_:
				print("ATTACH DEFAULT WEAPON")
				pass
	# attach carried item
	elif item_id != null:
		print("ATTACH CARRIED ITEM")
		var new_hand_instance = carried_item_scene.instance()
		new_hand_instance.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + GameData.item_data[str(item_id)]["Name"] + ".png")
		hand_pivot.add_child(new_hand_instance)
	# attach bare hands
	else:
		print("ATTACH BARE HANDS")
		var new_hand_instance = bare_hands_scene.instance()
		# for future speed atk bonuses
		new_hand_instance.get_node("AnimationPlayer").playback_speed = 1.0
		hand_pivot.add_child(new_hand_instance)
		
	
func select():
	pass
	#var weaponName = GameData.item_data[str(PlayerData.equipment_data["MainHand"])]["Name"]
	#var texture = load("res://Assets/Items_Icons/" + weaponName + ".png")
	#sprite.texture = texture


func _on_WeaponAnimations_animation_finished(anim_name):
	ready_for_attack = true

extends Node2D
class_name MainHand

var melee_weapon_scene = load("res://Scenes/Main_Hand/Melee_Weapon.tscn")
var carried_item_scene = load("res://Scenes/Main_Hand/Carried_Item.tscn")
var bare_hands_scene = load("res://Scenes/Main_Hand/Bare_Hands.tscn")

var ready_for_attack = true
onready var hand_pivot = get_node("HandPivot")





func _ready():
	select_item(1)
	SignalBus.connect("on_selected_item_change",self,"select_item")
	
func make_action(angle):
	# temporary just swing
	hand_pivot.get_child(0).swing()
	
func select_item(new_item_inv_index):
	print("selected item index",new_item_inv_index)
	var item_id = PlayerData.inv_data["Inv"+str(new_item_inv_index)]["Item"]
	if hand_pivot.get_child_count() > 0:
		print("delete hand child")
		hand_pivot.get_child(0).queue_free()
	
	if item_id:
		var item_details = GameData.item_data[str(item_id)]
		match item_details["Category"]:
			"Melee Weapon":
				var new_hand_instance = melee_weapon_scene.instance()
				new_hand_instance.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + item_details["Name"] + ".png")
				new_hand_instance.get_node("AnimationPlayer").playback_speed = 2.0
				print("add hand weapon")
				hand_pivot.add_child(new_hand_instance)
				
			_:
				var new_hand_instance = carried_item_scene.instance()
				new_hand_instance.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + item_details["Name"] + ".png")
				print("add hand carried")
				hand_pivot.add_child(new_hand_instance)
	else:
		var new_hand_instance = bare_hands_scene.instance()
		# for future speed atk bonuses
		new_hand_instance.get_node("AnimationPlayer").playback_speed = 1.0
		print("add hand bare hands")
		hand_pivot.add_child(new_hand_instance)
		
	
func select():
	pass
	#var weaponName = GameData.item_data[str(PlayerData.equipment_data["MainHand"])]["Name"]
	#var texture = load("res://Assets/Items_Icons/" + weaponName + ".png")
	#sprite.texture = texture


func _on_WeaponAnimations_animation_finished(anim_name):
	ready_for_attack = true

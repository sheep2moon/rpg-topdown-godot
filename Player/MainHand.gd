extends Node2D
class_name MainHand

onready var player = get_parent()
var melee_weapon_scene = load("res://Scenes/Main_Hand/Melee_Weapon.tscn")
var carried_item_scene = load("res://Scenes/Main_Hand/Carried_Item.tscn")
var bare_hands_scene = load("res://Scenes/Main_Hand/Bare_Hands.tscn")
var distance_weapon_scene = load("res://Scenes/Main_Hand/DistanceWeapon.tscn")

onready var hand_pivot = get_node("HandPivot")


func _ready():
	select_item(1)
	SignalBus.connect("on_selected_item_change",self,"select_item")
	

func select_item(new_item_inv_index):
	var item_id = PlayerData.inv_data["Inv"+str(new_item_inv_index)]["Item"]
	
	hand_pivot.get_node("BareHands").visible = false
	hand_pivot.get_node("Carried_Item").visible = false
	hand_pivot.get_node("DistanceWeapon").visible = false
	hand_pivot.get_node("Melee_Weapon").visible = false
	hand_pivot.get_node("Tool").visible = false
	
	if item_id != null and GameData.item_data[str(item_id)]["Category"] == "Weapon":
		match GameData.item_data[str(item_id)]["Type"]:
			"Melee":
				player.current_hand_scene = "Melee_Weapon"
				var target_node = hand_pivot.get_node("Melee_Weapon")
				target_node.visible = true
				target_node.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + GameData.item_data[str(item_id)]["Name"] + ".png")
				target_node.get_node("AnimationPlayer").playback_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
				target_node.get_node("Hinge/Sprite/Hitbox").damage = float(GameData.item_data[str(item_id)]["Attack"])
				target_node.main_action_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
			"Bow":
				player.current_hand_scene = "DistanceWeapon"
				var target_node = hand_pivot.get_node("DistanceWeapon")
				target_node.visible = true
				target_node.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + GameData.item_data[str(item_id)]["Name"] + ".png")
				target_node.get_node("AnimationPlayer").playback_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
				target_node.main_action_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
	elif item_id != null and GameData.item_data[str(item_id)]["Category"] == "Tool":
		player.current_hand_scene = "Tool"
		var target_node = hand_pivot.get_node("Tool")
		target_node.visible = true
		target_node.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + GameData.item_data[str(item_id)]["Name"] + ".png")
		target_node.get_node("AnimationPlayer").playback_speed = GameData.item_data[str(item_id)]["AttackSpeed"]
		target_node.tool_type = GameData.item_data[str(item_id)]["Type"]
	elif item_id != null:
		player.current_hand_scene = "Carried_Item"
		var target_node = hand_pivot.get_node("Carried_Item")
		target_node.visible = true
		target_node.get_node("Hinge/Sprite").texture = load("res://Assets/Items_Icons/" + GameData.item_data[str(item_id)]["Name"] + ".png")
	else:
		player.current_hand_scene = "BareHands"
		var target_node = hand_pivot.get_node("BareHands")
		target_node.visible = true
		

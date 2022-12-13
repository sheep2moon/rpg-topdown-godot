extends CanvasLayer

onready var player: KinematicBody2D = $"../Navigation2D/YSort/Player"
onready var player_main_hand = $"../Navigation2D/YSort/Player/MainHand"



onready var Inventory = $Character/Inventory
onready var CharacterSheet = $Character/CharacterSheet
onready var Toolbar = $Character/Toolbar
onready var MainMenu = $GameMenu

onready var health_bar = $TopBar/HBoxContainer/HealthBar
onready var health_bar_tween = $TopBar/HBoxContainer/HealthBar/Tween
onready var mana_bar = $TopBar/HBoxContainer/ManaBar
onready var mana_bar_tween = $TopBar/HBoxContainer/ManaBar/Tween

func _ready():
	health_bar.max_value = player.hp
	pause_mode = Node.PAUSE_MODE_PROCESS
	SignalBus.connect("on_player_enter_pickup_item",self,"_on_player_enter_pickup_item")
	#health_bar.value = player.current_hp

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		Inventory.visible = !Inventory.visible
		CharacterSheet.visible = !CharacterSheet.visible
	if event.is_action_pressed("toggle_main_menu"):
		if MainMenu.visible:
			_on_Resume_pressed()
		else:
			MainMenu.visible = true
			get_tree().paused = true
	
func _process(delta):
	update_bars()

func update_bars():
	health_bar_tween.interpolate_property(health_bar,"value",health_bar.value,player.current_hp,0.1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	health_bar_tween.start()

func _on_Options_pressed():
	print("options")


func _on_Resume_pressed():
	MainMenu.visible = false
	get_tree().paused = false

func _on_CloseInventory_pressed():
	Inventory.visible = false
	CharacterSheet.visible = false


func _on_Save_pressed():
	PlayerData.save()

func _on_player_enter_pickup_item(item_id,quantity,item_node):
	var slot_name = PlayerData.add_to_inventory(item_id,quantity)
	if slot_name:
		var item_tween: Tween = item_node.get_node("Tween")
		item_tween.follow_property(item_node,"global_position",item_node.global_position,player,"global_position",0.5,Tween.TRANS_BACK,Tween.EASE_IN_OUT)
		#item_tween.interpolate_property(item_node,"global_position",item_node.global_position,player.global_position,2.0,Tween.TRANS_BACK,Tween.EASE_IN_OUT)
		item_tween.start()
		item_tween.connect("tween_all_completed",self,"_add_to_inventory",[item_id,quantity,item_node,slot_name])
	#Inv full - do nothing
	else:
		pass
		
	#item_node.queue_free()
	
	
	

func _add_to_inventory(item_id,quantity,item_node,slot_name):
	item_node.queue_free()
	var slot_index = int(slot_name.lstrip("Inv"))
	if slot_index < 9:
		Toolbar.update_inventory_slot(slot_name)
	else:
		Inventory.update_inventory_slot(slot_name)
	


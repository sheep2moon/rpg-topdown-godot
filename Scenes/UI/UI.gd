extends CanvasLayer

onready var world_node = $"../Navigation2D/YSort"
onready var player: KinematicBody2D = $"../Navigation2D/YSort/Player"
onready var player_main_hand = $"../Navigation2D/YSort/Player/MainHand"
onready var player_camera: Camera2D = $"../Navigation2D/YSort/Player/Camera2D"


onready var Inventory = $Character/Inventory
onready var BuildMenu = $Character/BuildMenu
onready var CharacterSheet = $Character/CharacterSheet
onready var Toolbar = $Character/Toolbar
onready var MainMenu = $GameMenu


onready var expierience_bar = $LevelCoinsBar/ExpProgress
onready var level_label = $LevelCoinsBar/PlayerLevelBg/LevelLabel
onready var coins_label: Label = $LevelCoinsBar/Coins
onready var health_bar = $TopBar/HBoxContainer/HealthBar
onready var health_bar_tween = $TopBar/HBoxContainer/HealthBar/Tween
onready var energy_bar = $TopBar/HBoxContainer/EnergyBar
onready var energy_bar_tween = $TopBar/HBoxContainer/EnergyBar/Tween


#Init UI values
func _ready():
	health_bar.max_value = PlayerData.hp
	energy_bar.max_value = PlayerData.energy

	expierience_bar.min_value = PlayerData.get_next_level_xp(PlayerData.level - 1)
	expierience_bar.max_value = PlayerData.get_next_level_xp(PlayerData.level)
	expierience_bar.value = PlayerData.xp
	
	coins_label.set_text(str(PlayerData.coins))
	level_label.set_text(str(PlayerData.level))
	
	pause_mode = Node.PAUSE_MODE_PROCESS
	SignalBus.connect("on_player_enter_pickup_item",self,"_on_player_enter_pickup_item")
	SignalBus.connect("on_expierience_gained",self,"_on_expierience_gained")
	SignalBus.connect("on_building_menu_select",self,"_on_building_menu_select")
	#health_bar.value = player.current_hp

func _input(event):
	if event.is_action_pressed("toggle_inventory"):
		Inventory.visible = !Inventory.visible
		CharacterSheet.visible = !CharacterSheet.visible
	if event.is_action_pressed("toggle_building_menu"):
		BuildMenu.visible = !BuildMenu.visible
	if event.is_action_pressed("toggle_main_menu"):
		if MainMenu.visible:
			_on_Resume_pressed()
		else:
			MainMenu.visible = true
			get_tree().paused = true
	
func _process(delta):
	update_bars()

func update_bars():
	health_bar_tween.interpolate_property(health_bar,"value",health_bar.value,PlayerData.current_hp,0.1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	health_bar_tween.start()
	energy_bar_tween.interpolate_property(energy_bar,"value",energy_bar.value,PlayerData.current_energy,0.1,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	energy_bar_tween.start()

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
	
	if item_id == "1000":
		var item_tween: Tween = item_node.get_node("Tween")
		#get_coins_label_global_pos()
		#item_tween.follow_method(item_node,"set_global_position",item_node.global_position,self,"get_coins_label_global_pos",1,Tween.TRANS_BACK,Tween.EASE_IN_OUT)
		#item_tween.interpolate_property(item_node,"modulate:a",1.0,0.0,0.5,Tween.TRANS_LINEAR,Tween.EASE_IN_OUT,0.5)
		item_tween.follow_property(item_node,"global_position",item_node.global_position,player,"global_position",0.5,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		item_tween.start()
		item_tween.connect("tween_all_completed",self,"on_coin_update_score",[item_node])
		return
	
	var slot_name = PlayerData.add_to_inventory(item_id,quantity)
	if slot_name:
		var item_tween: Tween = item_node.get_node("Tween")
		item_tween.follow_property(item_node,"global_position",item_node.global_position,player,"global_position",0.5,Tween.TRANS_CUBIC,Tween.EASE_IN_OUT)
		#item_tween.interpolate_property(item_node,"global_position",item_node.global_position,player.global_position,2.0,Tween.TRANS_BACK,Tween.EASE_IN_OUT)
		item_tween.start()
		item_tween.connect("tween_all_completed",self,"_add_to_inventory",[item_id,quantity,item_node,slot_name])
	#Inv full - do nothing
	else:
		pass
		
	#item_node.queue_free()
func on_coin_update_score(coin):
	PlayerData.coins += 1
	coins_label.set_text(str(PlayerData.coins))
	coin.queue_free()
	

func _add_to_inventory(item_id,quantity,item_node,slot_name):
	item_node.queue_free()
	var slot_index = int(slot_name.lstrip("Inv"))
	print(slot_name)
	if slot_index < 9:
		Toolbar.update_inventory_slot(slot_name)
	else:
		Inventory.update_inventory_slot(slot_name)
	
func _on_expierience_gained():
	var tween = expierience_bar.get_parent().get_node("Tween")
	expierience_bar.min_value = PlayerData.get_next_level_xp(PlayerData.level - 1)
	expierience_bar.max_value = PlayerData.get_next_level_xp(PlayerData.level)
	print(PlayerData.xp,expierience_bar.value)
	tween.interpolate_property(expierience_bar,"value",expierience_bar.value,PlayerData.xp,0.5,Tween.TRANS_CUBIC,Tween.EASE_OUT)
	tween.start()
	level_label.set_text(str(PlayerData.level))
	
func _on_building_menu_select(building_name):
	BuildMenu.visible = false
	var building_scene = load("res://Scenes/Buildable/"+building_name+".tscn")
	var building_instance = building_scene.instance()
	building_instance.build_name = building_name
	world_node.add_child(building_instance)

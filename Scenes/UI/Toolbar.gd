extends InvenoryHandler

onready var toolbar_container = $SlotsContainer


func _ready():
	if PlayerData.inv_data:	
		var inventory_keys: Array = PlayerData.inv_data.keys()
		for i in inventory_keys.slice(0,7):
			var inv_slot_new = create_inv_slot(i)
			toolbar_container.add_child(inv_slot_new,true)
	select_tool(1)
		
func _unhandled_key_input(event):
	if event.pressed:
		match event.scancode:
			KEY_1:
				select_tool(1)
			KEY_2:
				select_tool(2)
			KEY_3:
				select_tool(3)
			KEY_4:
				select_tool(4)
			KEY_5:
				select_tool(5)
			KEY_6:
				select_tool(6)
			KEY_7:
				select_tool(7)
			KEY_8:
				select_tool(8)
		

func select_tool(idx):
	toolbar_container.get_child(PlayerData.selected_tool-1).get_node("Active").visible = false
	PlayerData.selected_tool = idx
	toolbar_container.get_child(idx-1).get_node("Active").visible = true
	SignalBus.emit_signal("on_selected_item_change",idx)

func update_inventory_slot(slot_name):
	update_slot(slot_name,toolbar_container)




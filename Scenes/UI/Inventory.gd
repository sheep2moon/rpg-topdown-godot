extends InvenoryHandler


onready var grid_container = $Background/M/V/GridContainer


func _ready():
	if PlayerData.inv_data:	
		var inventory_keys: Array = PlayerData.inv_data.keys()
		for i in inventory_keys.slice(8,-1):
			var inv_slot_new = create_inv_slot(i)
			grid_container.add_child(inv_slot_new,true)

func update_inventory_slot(slot_name):
	update_slot(slot_name,grid_container)
	

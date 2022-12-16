extends Node


signal on_drop_items(position,item_id,quantity)
signal on_selected_item_change(selected_item_index)
signal on_player_enter_pickup_item(item_id,quantity,item_node)
signal on_equipment_item_change(equipment_slot)
signal shake_camera(duration,frequency,amplitude)
signal launch_projectile(projectile,position,direction)
signal on_expierience_gained()
signal on_building_menu_select(building_name)

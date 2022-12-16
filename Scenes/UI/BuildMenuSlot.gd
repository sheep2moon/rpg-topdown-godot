extends TextureButton


func _on_BuildMenuSlot_pressed():
	SignalBus.emit_signal("on_building_menu_select",name)

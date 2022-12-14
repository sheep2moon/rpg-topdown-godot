extends StaticBody2D


func _on_Area2D_area_entered(area):
	if area.has_method("use_tool"):
		area.use_tool()
		if $Sprite.frame == 3:
			queue_free()
			SignalBus.emit_signal("on_drop_items",global_position,"2001",6)
		else:
			$Sprite.frame += 1

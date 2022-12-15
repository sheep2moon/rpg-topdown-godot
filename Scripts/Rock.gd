extends StaticBody2D


func _on_Area2D_area_entered(area):
	if area.has_method("use_tool"):
		area.use_tool()
		SignalBus.emit_signal("shake_camera",0.1,5,4)
		$AnimationPlayer.play("Stroke")
		if $Sprite.frame == 3:
			queue_free()
			SignalBus.emit_signal("on_drop_items",global_position,"2001",6)
		else:
			$Sprite.frame += 1

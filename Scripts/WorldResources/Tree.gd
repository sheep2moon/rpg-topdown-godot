extends StaticBody2D

var stage = 0

func _ready():
	$Sprite.visible = true
	$Sprite.frame = 0
	$Stump.visible = false
	$Chopped.visible = false
	$Stroke.visible = false
	$LeavesParticles.emitting = false
		
func _on_Area2D_area_entered(area):
	if area.has_method("use_tool") and stage < 6:
		$AnimationPlayer.play("Stroke")
		stage += 1
		SignalBus.emit_signal("shake_camera",0.1,5,4)
		if stage == 2:
			$Sprite.frame = 1
		if stage == 4: 
			$Sprite.frame = 2
		if stage == 6:
			$Sprite.visible = false
			$Stroke.visible = false
			$LeavesParticles.emitting = false
			$AnimationPlayer.play("Fall")


func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "Fall":
		#queue_free()
		$Area2D/CollisionShape2D.disabled = true
		$Chopped.visible = false
		SignalBus.emit_signal("on_drop_items",global_position,"2002",4)
		
func shake_camera():
	SignalBus.emit_signal("shake_camera",0.3,6,22)

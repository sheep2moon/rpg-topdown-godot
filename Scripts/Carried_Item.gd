extends MainHandFist


func _ready():
	visible = false
	animation_player.connect("animation_finished",self,"on_animation_ended")
	$Hinge/Sprite/Hitbox/CollisionShape2D.disabled = true

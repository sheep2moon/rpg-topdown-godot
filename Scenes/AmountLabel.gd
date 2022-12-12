extends Position2D

onready var label = $Label
onready var tween = $Tween
var amount = 0
var type = "Damage"
var velocity = Vector2(0,0)
var max_size = Vector2(0.6,0.6)


# Called when the node enters the scene tree for the first time.
func _ready():
	label.set_text(str(amount))
	randomize()
	var side_movement = randi() % 41 + 20
	velocity = Vector2(side_movement,10)
	
	match type:
		"Heal":
			label.set("custom_colors/font_color",Color("2eff27"))
		"Damage":
			label.set("custom_colors/font_color",Color("913e3e"))
		"Critical":
			max_size = Vector2(1.1,1.1)
			label.set("custom_colors/font_color",Color("d02626"))
		"Expierience":
			label.set("custom_colors/font_color",Color("eeeeee"))
			velocity = Vector2.ZERO
	
	
	tween.interpolate_property(self,"scale", scale, max_size,0.2,Tween.TRANS_LINEAR,Tween.EASE_OUT)
	tween.interpolate_property(self,"scale", max_size, Vector2(0.1,0.1),0.5,Tween.TRANS_LINEAR,Tween.EASE_OUT,0.3)
	tween.start()
	


func _on_Tween_tween_all_completed():
	self.queue_free()

func _process(delta):
	position -= velocity * delta

extends Hitbox

onready var timer = $Timer
var direction := Vector2.ZERO
var speed := 100


func _ready():
	timer.start()

func _physics_process(delta):
	if direction != Vector2.ZERO:
		global_position += direction * speed * delta

func set_direction(direction: Vector2):
	self.direction = direction
	rotation = direction.angle() + PI/2



func _on_area_entered(area: Area2D):
	if area.has_method("take_damage"):
		area.take_damage(damage,knockback_direction,knockback_power)
	queue_free()


func _on_Timer_timeout():
	queue_free()

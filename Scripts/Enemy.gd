extends KinematicBody2D
class_name Enemy


var loot_randomizer := RandomNumberGenerator.new()

export var life := 50
export var expierience := 500
var _velocity := Vector2.ZERO

var loot = {}

onready var _player: KinematicBody2D = get_node("../../Player")
onready var _agent = $NavigationAgent2D
onready var _animations = $AnimationPlayer
onready var spawnPoint = global_position
onready var state_machine = $StateMachine


func _physics_process(delta):
	_velocity = move_and_slide(_velocity)

func should_idle():
	return _agent.is_navigation_finished()

func should_return_spawn():
	if _player.position.distance_to(global_position) > 300 and  global_position.snapped(Vector2(1,1)) != spawnPoint:
		return true
	else: 
		_velocity = Vector2.ZERO
		return false

func return_spawn():
	_agent.set_target_location(spawnPoint)
	go_to_target()

func should_chase():
	return _player.position.distance_to(global_position) < 200

func can_attack():
	return _player.position.distance_to(global_position) < 30

func chase_player(delta: float):
	_agent.set_target_location(_player.global_position)
	go_to_target()
	

func go_to_target():
	var direction := global_position.direction_to(_agent.get_next_location())
	var desired_velocity := direction * 40.0
	var steering := (desired_velocity - _velocity) * 0.5	
	_velocity += steering
	if abs(_velocity.angle()) > PI/2 :
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false

	

func attack():
	var angle = global_position.angle_to_point(_player.global_position)
	$Hitbox.rotation = angle+PI
	if abs(angle) < PI/2 :
		$Sprite.flip_h = true
	else:
		$Sprite.flip_h = false
	
func drop_items():
	loot_randomizer.randomize()
	var rand = 1 - loot_randomizer.randf()
	for item_id in loot.keys():
		if rand <= loot[item_id].chance:
			var quantity = loot_randomizer.randi_range(loot[item_id]["quantity"][0],loot[item_id]["quantity"][1])
			SignalBus.emit_signal("on_drop_items",global_position,item_id,quantity)
	


func die():
	set_physics_process(false)
	drop_items()
	_player.on_kill(expierience)
	state_machine.set_state(state_machine.states.die)

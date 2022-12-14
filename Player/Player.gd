extends KinematicBody2D


var mov_direction := Vector2.ZERO
var _velocity: Vector2 = Vector2.ZERO

const EXP_LABEL = preload("res://Scenes/AmountLabel.tscn")
const FRICTION: float = 0.15
onready var main_hand = $MainHand
onready var player_sprite = $Sprite
onready var _animations = $AnimationPlayer


var accerelation = 100
var max_speed = 120
var hp_regen = 1
var energy_regen = 2
var level = 1
var player_xp = 0
var current_hand_scene: String

func _ready():
	pass

func get_input(delta):
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		mov_direction += Vector2(-1,0)
	if Input.is_action_pressed("move_right"):
		mov_direction += Vector2(1,0)
	if Input.is_action_pressed("move_up"):
		mov_direction += Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		mov_direction += Vector2(0,1)
		
	if Input.is_action_pressed("sprint"):
		max_speed = 160
		PlayerData.current_energy -= 5 * delta
	if Input.is_action_just_released("sprint"):
		max_speed = 120
		
	#for i in range(main_hand.get_node("HandPivot").get_child_count()):
	if current_hand_scene:
		main_hand.get_node("HandPivot").get_node(current_hand_scene).get_input()


func _process(delta):
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	
		

func _physics_process(delta):
	regen_hp(delta)
	regen_energy(delta)
	mov_direction = mov_direction.normalized()
	if mov_direction == Vector2.ZERO:
		$AnimationTree.get("parameters/playback").travel("Idle")
	else:
		$AnimationTree.get("parameters/playback").travel("Walk")
		$AnimationTree.set("parameters/Idle/blend_position",mov_direction)
		$AnimationTree.set("parameters/Walk/blend_position",mov_direction)
	_velocity += mov_direction * accerelation
	_velocity = _velocity.clamped(max_speed)
	_velocity = move_and_slide(_velocity)
	_velocity = lerp(_velocity, Vector2.ZERO, FRICTION)
	

func regen_hp(delta):
	if PlayerData.current_hp < PlayerData.hp:
		PlayerData.current_hp += hp_regen * delta

func regen_energy(delta):
	if PlayerData.current_energy < PlayerData.energy:
		PlayerData.current_energy += energy_regen * delta

func on_kill(expierience):
	var exp_label: Position2D = EXP_LABEL.instance()
	exp_label.amount = expierience
	exp_label.type = "Expierience"
	add_child(exp_label)
	player_xp += expierience
	if player_xp >= get_next_level_xp(level):
		level += 1
	

func get_next_level_xp(level):
	return 128 * pow(level,2)







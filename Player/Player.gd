extends KinematicBody2D

signal on_item_picked_up(item_id)

var mov_direction := Vector2.ZERO
var _velocity: Vector2 = Vector2.ZERO

const EXP_LABEL = preload("res://Scenes/AmountLabel.tscn")
const FRICTION: float = 0.15
onready var main_hand = $MainHand
onready var player_sprite = $"Sprites/player_spritesheet"
onready var _animations = $AnimationPlayer

var hp = 100
var current_hp
var accerelation = 100
var max_speed = 120
var hp_regen = 2

func _ready():
	current_hp = hp


func _process(delta):
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		mov_direction = Vector2(-1,0)
	if Input.is_action_pressed("move_right"):
		mov_direction = Vector2(1,0)
	if Input.is_action_pressed("move_up"):
		mov_direction = Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		mov_direction = Vector2(0,1)
	if Input.is_action_just_pressed("attack"):
		attack()
		
	var mouse_direction: Vector2 = (get_global_mouse_position() - global_position).normalized()
	
	if mouse_direction.x > 0 and player_sprite.flip_h:
		player_sprite.flip_h = false
	elif mouse_direction.x < 0 and not player_sprite.flip_h:
		player_sprite.flip_h = true

		

func _physics_process(delta):
	regen_hp(delta)
	mov_direction = mov_direction.normalized()
	_velocity += mov_direction * accerelation
	_velocity = _velocity.clamped(max_speed)
	_velocity = move_and_slide(_velocity)
	_velocity = lerp(_velocity, Vector2.ZERO, FRICTION)
	

func regen_hp(delta):
	if current_hp < hp:
		current_hp += hp_regen * delta

func pick_up_item(id):
	print("Player - pick up item ID:",id)
	emit_signal("on_item_picked_up",id)

func attack():
	main_hand.make_action(get_angle_to(get_global_mouse_position()))

func on_kill(expierience):
	print(expierience)
	var exp_label: Position2D = EXP_LABEL.instance()
	exp_label.amount = expierience
	exp_label.type = "Expierience"
	add_child(exp_label)







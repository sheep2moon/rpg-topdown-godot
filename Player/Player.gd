extends KinematicBody2D


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
var level = 1
var player_xp = 0

func _ready():
	current_hp = hp

func get_input():
	mov_direction = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		mov_direction = Vector2(-1,0)
	if Input.is_action_pressed("move_right"):
		mov_direction = Vector2(1,0)
	if Input.is_action_pressed("move_up"):
		mov_direction = Vector2(0,-1)
	if Input.is_action_pressed("move_down"):
		mov_direction = Vector2(0,1)
	main_hand.get_node("HandPivot").get_child(0).get_input()


func _process(delta):
	
	#if Input.is_action_pressed("move_left"):
	#	mov_direction = Vector2(-1,0)
	#if Input.is_action_pressed("move_right"):
	#	mov_direction = Vector2(1,0)
	#if Input.is_action_pressed("move_up"):
	#	mov_direction = Vector2(0,-1)
	#if Input.is_action_pressed("move_down"):
	#	mov_direction = Vector2(0,1)
	#if Input.is_action_just_pressed("attack"):
	#	main_hand.make_action(get_angle_to(get_global_mouse_position()))

		
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







extends Node2D

var amplitude = 0
onready var camera = get_parent()
onready var tween: Tween = $Tween


func _ready():
	SignalBus.connect("shake_camera",self,"start")

func start(duration = 0.2,frequency = 15, amplitude = 12):
	self.amplitude = amplitude
	
	$Duration.wait_time = duration
	$Frequency.wait_time = 1 / float(frequency)
	$Duration.start()
	$Frequency.start()
	
	_new_shake()

func _new_shake():
	var rand = Vector2()
	rand.x = rand_range(-amplitude,amplitude)
	rand.y = rand_range(-amplitude,amplitude)
	
	tween.interpolate_property(camera,"offset",camera.offset,rand,$Frequency.wait_time,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	
func _reset():
	tween.interpolate_property(camera,"offset",camera.offset,Vector2(),$Frequency.wait_time,Tween.TRANS_SINE,Tween.EASE_IN_OUT)
	tween.start()
	

func _on_Frequency_timeout():
	_new_shake()


func _on_Duration_timeout():
	_reset()
	$Frequency.stop()

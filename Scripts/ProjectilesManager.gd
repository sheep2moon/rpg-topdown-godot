extends Node2D


func _ready():
	SignalBus.connect("launch_projectile",self,"_on_launch_projectile")

func _on_launch_projectile(projectile,position,direction):
	add_child(projectile)
	projectile.global_position = position
	projectile.set_direction(direction)

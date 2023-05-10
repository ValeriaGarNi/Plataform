extends Area2D

#export(bool) var show_hit = true

var invincible = false setget set_invincible

onready var timer = $Timer

signal invincibility_started
signal invincibility_ended

func set_invincible(value):
	invincible = value
	if invincible == true:
		emit_signal("invincibility_started")
	else:
		emit_signal("invincibility_ended")
		
func start_invincibility(duracion):
	self.invincible = true
	timer.start(duracion)
	
const EfectoGolpear = preload("res://Effects/EfectoGolpear.tscn")

func create_hit_effect():
		var efecto = EfectoGolpear.instance()
		var main = get_tree().current_scene
		main.add_child(efecto)
		efecto.global_position = global_position

func _on_Timer_timeout():
	self.invincible = false


func _on_Hurtbox_invincibility_started():
	set_deferred("monitorable", false)


func _on_Hurtbox_invincibility_ended():
	monitorable = true

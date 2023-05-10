extends Node2D

const EfectoHierba = preload("res://Effects/EfectoHierba.tscn")

func create_grass_effect():
	var efectoHierba = EfectoHierba.instance()
	var Mundo = get_tree().current_scene
	Mundo.add_child(efectoHierba)
	efectoHierba.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()

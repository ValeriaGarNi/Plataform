extends Node2D

func create_grass_effect():
	var EfectoHierba = load("res://Effects/EfectoHierba.tscn")
	var efectoHierba = EfectoHierba.instance()
	var Mundo = get_tree().current_scene
	Mundo.add_child(efectoHierba)
	efectoHierba.global_position = global_position


func _on_Hurtbox_area_entered(area):
	create_grass_effect()
	queue_free()

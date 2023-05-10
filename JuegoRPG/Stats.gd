extends Node

export(int) var vida_max = 1
onready var vida = vida_max setget set_vida

signal no_vida

func set_vida(value):
	vida = value
	if vida <= 0:
		emit_signal("no_vida")

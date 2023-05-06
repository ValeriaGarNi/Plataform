extends Node2D


var pueblo = load("res://pueblo.tscn").instance()
var Personaje = load("res://World/Player/Personaje.tscn").instance()
var bosque = preload("res://Bosque.tscn").instance()
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "Personaje":
		get_node("/root/").add_child(pueblo)
		$".".queue_free()
		get_node("/root/pueblo/Positionentradapueblosur").add_child(Personaje)
	
	pass # Replace with function body.


func _on_Area2D2_body_entered(body):
	if body.name == "Personaje":
		get_node("/root/").add_child(bosque)
		$".".queue_free()
		get_node("/root/bosque/Positionentradabosque").add_child(Personaje)
		pass # Replace with function body.

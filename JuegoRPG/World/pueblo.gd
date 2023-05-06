extends Node2D

var Personaje = preload("res://World/Player/Personaje.tscn").instance()

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_salida_sur_body_entered(body):
	print(body.name)
	var mundoprincipal = preload("res://mundo principal2.tscn").instance()
	if body.name == "Personaje":
		get_node("/root/").add_child(mundoprincipal)
		$".".queue_free()
		get_node("/root/mundoPrincipal2/Positionsalidapueblosur").add_child(Personaje)
	pass # Replace with function body.

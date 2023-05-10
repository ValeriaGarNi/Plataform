extends Area2D

var personaje = null

func can_see_player():
	return personaje != null

func _on_DetectarJugador_body_entered(body):
	personaje = body



func _on_DetectarJugador_body_exited(body):
	personaje = null

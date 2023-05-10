extends KinematicBody2D

const EfectoMuerteEnemigo = preload("res://Effects/EfectoMuerteEnemigo.tscn")

export var ACELERACION = 300
export var VELOCIDAD_MAX = 50
export var FRICCION = 200

enum {
	INMOVIL,
	DEAMBULAR,
	PERSEGUIR
}

var velocidad = Vector2.ZERO
var knockback = Vector2.ZERO
var state = PERSEGUIR

onready var sprite = $AnimatedSprite
onready var stats = $Stats
onready var detectarPersonaje = $DetectarJugador
onready var hurtbox = $Hurtbox

func _physics_process(delta):
	knockback = knockback.move_toward(Vector2.ZERO, delta * 200)
	knockback = move_and_slide(knockback)
	
	match state:
		INMOVIL:
			velocidad = velocidad.move_toward(Vector2.ZERO, FRICCION * delta)
			seek_player()
		
		DEAMBULAR:
			pass
			
		PERSEGUIR:
			var personaje = detectarPersonaje.personaje
			if personaje != null:
				var direccion = (personaje.global_position - global_position).normalized()
				velocidad = velocidad.move_toward(direccion * VELOCIDAD_MAX, ACELERACION * delta)
			else:
				state = INMOVIL
			sprite.flip_h = velocidad.x < 0
			
	velocidad = move_and_slide(velocidad)
			
func seek_player():
	if detectarPersonaje.can_see_player():
		state = PERSEGUIR

func _on_Hurtbox_area_entered(area):
	stats.vida -= area.damage
	knockback = area.knockback_vector * 120
	hurtbox.create_hit_effect()

func _on_Stats_no_vida():
	var efectoMuerteEnemigo = EfectoMuerteEnemigo.instance()
	var main = get_tree().current_scene
	main.add_child(efectoMuerteEnemigo)
	efectoMuerteEnemigo.global_position = global_position
	queue_free()

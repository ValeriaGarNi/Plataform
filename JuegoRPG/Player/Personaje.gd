extends KinematicBody2D

const aceleracion = 500
const velocidad_max = 80
const friccion = 500

enum {
	MOVIMIENTO,
	ATAQUE
}

var state = MOVIMIENTO
var velocidad = Vector2.ZERO

onready var animacionJugador = $AnimationPlayer
onready var animationTree = $AnimationTree
onready var animationState = animationTree.get("parameters/playback")

func _ready():
	animationTree.active = true

func _physics_process(delta):
	match state:
		MOVIMIENTO:
			movimiento_state(delta)
		
		ATAQUE:
			ataque_state(delta)
	
func movimiento_state(delta):
	var input_vector = Vector2.ZERO
	input_vector.x = Input.get_action_strength("ui_right") - Input.get_action_strength("ui_left")
	input_vector.y = Input.get_action_strength("ui_down") - Input.get_action_strength("ui_up")
	input_vector = input_vector.normalized()
	#print("velocidad")
	
	if input_vector != Vector2.ZERO:
		animationTree.set("parameters/Parar/blend_position", input_vector)
		animationTree.set("parameters/Correr/blend_position", input_vector)
		animationTree.set("parameters/Atacar/blend_position", input_vector)
		animationState.travel("Correr")
		velocidad = velocidad.move_toward(input_vector * velocidad_max, aceleracion * delta)
		
	else:
		animationState.travel("Parar")
		velocidad = velocidad.move_toward(Vector2.ZERO, friccion * delta)
		
	velocidad = move_and_slide(velocidad)
	
	if Input.is_action_just_pressed("Atacar"):
		state = ATAQUE
	
func ataque_state(delta):
	velocidad = Vector2.ZERO
	animationState.travel("Atacar")

func ataque_animation_finished():
	state = MOVIMIENTO

extends CharacterBody3D
class_name Player

#TODO passer sur une state machine pour les mouvements

##For now the camera is directly attached to the player, and will be unselected when wanting to do crazy stuff like cinematics
@onready var camera: Custom_Camera = $Custom_Camera

@export var speed = 10

func _ready()->void:
	Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _process(delta: float) -> void:

	var input_vector: Vector2 = Input.get_vector("Left", "Right", "Up", "Down")
	var direction: Vector3 = basis * Vector3(input_vector.x, 0, input_vector.y)
	velocity = direction * speed
	
	if Input.is_action_just_pressed("Pause"):
		match Input.mouse_mode:
			Input.MOUSE_MODE_CAPTURED:
				Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
			Input.MOUSE_MODE_VISIBLE:
				Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	
func _physics_process(delta: float) -> void:
	move_and_slide()
	
func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventMouseMotion and Input.mouse_mode == Input.MOUSE_MODE_CAPTURED:
		rotate_y(-event.relative.x * camera.sensitivity)
		camera.rotate_x(-event.relative.y * camera.sensitivity)
		camera.rotation.x = clamp(camera.rotation.x,deg_to_rad(-89),deg_to_rad(89))
	

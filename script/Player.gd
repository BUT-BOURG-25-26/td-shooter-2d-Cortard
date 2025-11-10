class_name Player extends CharacterBody2D

@export var speed: float = 500;
@export var touch_delta: int = 15;

@export var max_life: float = 10;
@export var start_life: float = 5;

var player_width = 100;
var view_size: Vector2

var life: float

func _ready() -> void:
	view_size = get_viewport_rect().size
	life = start_life

func take_damage(value: int) :
	life -= value
	if life < 0 :
		life = 0

func _physics_process(delta: float) -> void:
	var clickPressed = handle_click_inputs()
	if ! clickPressed :
		handle_keyboard_inputs()
	move_and_slide()

	if global_position.x < player_width/2 :
		global_position.x = player_width/2
	elif global_position.x > view_size.x - player_width/2 :
		global_position.x = view_size.x - player_width/2

func handle_click_inputs() -> bool :
	if ! Input.is_action_pressed("click") :
		return false

	var mouse_pos: Vector2 = get_viewport().get_mouse_position()
	var to_mouse: Vector2 = mouse_pos - position
	var movement = to_mouse.x
	if movement > speed :
		movement = speed
	if abs(movement) < touch_delta :
		velocity = Vector2.ZERO
		return true

	var direction: int
	if mouse_pos.x < position.x :
		direction = -1
	elif mouse_pos.x > position.x :
		direction = 1
	else :
		direction = 0

	velocity.x = speed * direction
	return true

func handle_keyboard_inputs() :
	var lateralMovementInput = Input.get_action_strength("move_right") - Input.get_action_strength("move_left") 
	velocity.x = lateralMovementInput * speed

func _on_shoot_timer_timeout() -> void:
	var bullet : Bullet = Bullet.create(position)
	get_tree().current_scene.add_child(bullet)
	

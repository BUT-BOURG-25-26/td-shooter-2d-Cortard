class_name Bullet extends Area2D

@export var speed: float = 10

var is_player: bool

static var selfPackedScene: PackedScene = preload("res://scene/Bullet.tscn")
static func create(_position: Vector2, _is_player: bool = true) -> Bullet:
	var instance = selfPackedScene.instantiate()
	instance.is_player = _is_player
	instance.position = _position
	return instance

var view_size: Vector2
func _ready() -> void:
	view_size = get_viewport_rect().size

func _physics_process(delta: float) -> void:
	position.y += speed * ( -1 if is_player else 1 ) 
	
	if global_position.y < 0  || global_position.y > view_size.y :
		queue_free()

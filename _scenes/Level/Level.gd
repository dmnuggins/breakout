extends Node

var ball_prefab = preload("res://_scenes/Ball/Ball.tscn")
var ball
var ball_start_position := Vector2(800, 475)

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("launch"):
		ball = ball_prefab.instance()
		add_child(ball)

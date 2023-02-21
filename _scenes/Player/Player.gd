extends KinematicBody2D

export var speed = 150.0
export var lives = 3
var launchable := true

# Instances ball prefab and sets spawn at BallPosition
func launch_ball(var prefab):
	$BallPosition.hide()
	var ball = prefab.instance()
	ball.global_position = $BallPosition.global_position
	launchable = false
	return ball

func launchable():
	return launchable

func reset_ball():
	launchable = true
	$BallPosition.show()
	pass

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_left"):
		velocity.x = -speed
		move_and_slide(velocity, Vector2.UP)
	if Input.is_action_pressed("move_right"):
		velocity.x = speed
		move_and_slide(velocity, Vector2.UP)
	
	move_and_slide(velocity * delta * speed, Vector2.UP)

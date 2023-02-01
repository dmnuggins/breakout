extends KinematicBody2D

export var speed = 500.0
var velocity = Vector2.ZERO
var motion_vec = Vector2.ZERO
var launch_angle = 0

func _ready():
	# randomizes the launch angle of the ball
	randomize()
	launch_angle = rand_range(-45, 45)
	launch_angle = deg2rad(launch_angle)

func _physics_process(delta):
	# when user presses "space" ball velocity and angle is set
	if Input.is_action_just_pressed("ui_accept"):
		motion_vec = Vector2(0, -speed).rotated(launch_angle)
	# ball is launched
	var collider = move_and_collide(motion_vec * delta)
	
	# if ball collides, ball will bounce
	if collider:
		motion_vec = motion_vec.bounce(collider.normal)

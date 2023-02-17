extends KinematicBody2D

export var speed = 600.0
var velocity = Vector2.ZERO
var motion_vec = Vector2.ZERO
var angle_factor = 7

func _ready():
	# randomizes the launch angle of the ball
	velocity.y = speed

func _physics_process(delta):
	# when user presses "space" ball velocity and angle is set
	# ball is launched
	var collider = move_and_slide(velocity, Vector2.UP)
	if is_on_ceiling():
		velocity.y = -velocity.y
		print("HIT - Ceiling")
	if is_on_wall():
		velocity.x = -velocity.x
		print("HIT - Wall")
	if is_on_floor():
		velocity.y = -velocity.y
		print("HIT - Paddle")
		for slide in get_slide_count():
			var collision = get_slide_collision(slide)
			velocity.x = (transform.origin.x - collision.collider.position.x) * angle_factor
	
	# normalizes the speed, so contacting edge of board does not dramatically increase magnitude of velocity vector
	velocity = (velocity.normalized() * speed)

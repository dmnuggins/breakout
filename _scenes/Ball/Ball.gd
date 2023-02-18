extends KinematicBody2D

export var speed = 600.0
var velocity = Vector2.ZERO
var motion_vec = Vector2.ZERO
var angle_factor = 7

func _ready():
	velocity.y = speed
	position = get_parent().find_node("Player").get_node("BallPosition").global_position
	pass
	
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
	
	if is_on_ceiling():
		velocity.y = -velocity.y
		print("HIT - Ceiling")
	if is_on_wall():
		$Wall.play()
		velocity.x = -velocity.x
		print("HIT - Wall")
	if is_on_floor():
		$Paddle.play()
		velocity.y = -velocity.y
		print("HIT - Paddle")
		for slide in get_slide_count():
			var collision = get_slide_collision(slide)
			velocity.x = (transform.origin.x - collision.collider.position.x) * angle_factor
	
	# normalizes the speed, so contacting edge of board does not dramatically increase magnitude of velocity vector
	velocity = (velocity.normalized() * speed)

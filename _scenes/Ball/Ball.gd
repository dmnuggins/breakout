extends KinematicBody2D

export var speed = 600.0
var velocity = Vector2.ZERO
var motion_vec = Vector2.ZERO
var angle_factor = 7

func _ready():
	velocity.y = speed
	pass
	
func _physics_process(delta):
	move_and_slide(velocity, Vector2.UP)
	
	if not break_brick():
		if is_on_ceiling():
			velocity.y = -velocity.y
			$Wall.play()
		if is_on_wall():
			$Wall.play()
			velocity.x = -velocity.x
		if is_on_floor():
			$Paddle.play()
			velocity.y = -velocity.y
			for slide in get_slide_count():
				var collision = get_slide_collision(slide)
				velocity.x = (transform.origin.x - collision.collider.position.x) * angle_factor
	
	# normalizes the speed, so contacting edge of board does not dramatically increase magnitude of velocity vector
	velocity = (velocity.normalized() * speed)

func break_brick() -> bool:
	for slide in get_slide_count():
		var collision := get_slide_collision(slide)
		
		# Brick in this case, bing the class
		if collision.collider is Brick: 
			speed += (collision.collider.row / 4.0) * get_parent().speed_multiplier
			collision.collider.break_brick()
			
			if is_on_wall():
				velocity.x = -velocity.x
				
			if is_on_ceiling() or is_on_floor():
				velocity.y = -velocity.y
			
			$Wall.play()
			return true
	
	return false

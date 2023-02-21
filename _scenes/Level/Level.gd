extends Node

var ball_prefab = preload("res://_scenes/Ball/Ball.tscn")
var ball
var speed_multiplier := 1.0

# Called when the node enters the scene tree for the first time.
func _ready():
	
	pass

func _physics_process(delta):
	if Input.is_action_just_pressed("launch"):
		if $Player.launchable():
			ball = $Player.launch_ball(ball_prefab)
#			print(ball)
			add_child(ball)
		else:
			print("Cannot launch ball")

func _on_DeadZone_body_entered(body):
	print("Body entered")
	ball.queue_free()
	$ResetTimer.start()

# timer to delay resettting ball
func _on_ResetTimer_timeout():
	$Player.reset_ball()
	pass # Replace with function body.

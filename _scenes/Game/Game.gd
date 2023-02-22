extends Node

export var speed_factor = 10
# preload ball prefab
var bricks_prefab = preload("res://_scenes/Brick/Bricks.tscn")
var ball_prefab = preload("res://_scenes/Ball/Ball.tscn")
var ball
onready var bricks = $Bricks
var speed_multiplier := 0.0
var difficulty := 1
var num_lives := 3
var score := 0
var game_over = false

func level_complete():
	bricks.queue_free() # despawn all bricks
	ball.queue_free() # despawns ball
	update_difficulty(1)
	# plus 1 life for each level completed
	num_lives += 1
	update_lives()
	# instantiate bricks prefab
	bricks = bricks_prefab.instance()
	add_child(bricks)
	# connect Bricks signals to Game.gd script functions
	bricks.connect("brick_broke", self, "_on_Bricks_brick_broke")
	bricks.connect("last_brick_broke", self, "_on_bricks_last_brick_broke")
	
	$Player.reset_ball()
	update_speed_multiplier()

# Called when the node enters the scene tree for the first time.
func _ready():
	update_lives()
	$UI/Score.set_text(str(0))
	$UI/Level.set_text(str(1))

func update_score(value: int):
	score += value
	$UI/Score.set_text(str(score))

func update_difficulty(value: int):
	difficulty += value
	$UI/Level.set_text(str(difficulty))

func update_lives():
	match num_lives:
		3:
			$UI/Lives.set_text("III")
		2:
			$UI/Lives.set_text("II")
		1:
			$UI/Lives.set_text("I")
		0:
			$UI/Lives.set_text("LAST LIFE")
		_:
			$UI/Lives.set_text("GAME OVER")

func update_speed_multiplier():
	speed_multiplier = speed_factor * difficulty

func reset():
	bricks.queue_free()
	score = 0
	difficulty = 1
	num_lives = 3
	speed_multiplier = 0.0
	game_over = false
	
	update_score(0)
	update_lives()
	load_level()

func load_level():
	num_lives = 3
	update_lives()
	bricks = bricks_prefab.instance()
	add_child(bricks)
	bricks.connect("brick_broke", self, "_on_Bricks_brick_broke")
	bricks.connect("last_brick_broke", self, "_on_bricks_last_brick_broke")
	
	$UI/Level.set_text(str(difficulty))
	$Player.reset_ball()
	update_speed_multiplier()

func _physics_process(delta):
	
	if Input.is_action_just_pressed("launch"):
		if game_over:
			reset()
		elif $Player.launchable():
			ball = $Player.launch_ball(ball_prefab)
#			print(ball)
			add_child(ball)
		else:
			print("Cannot launch ball")

func _on_DeadZone_body_entered(body):
	num_lives -= 1
	update_lives()
	ball.queue_free()
	
	if num_lives >= 0:
#		$ResetTimer.start()
		$Player.reset_ball()
	else:
		game_over = true

# timer to delay resettting ball
func _on_ResetTimer_timeout():
	$Player.reset_ball()

func _on_Bricks_brick_broke(row: int):
	update_score(row + 1)

func _on_Bricks_last_brick_broke():
	level_complete()


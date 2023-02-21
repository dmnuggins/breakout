extends Node2D

signal brick_broke
signal last_brick_broke
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

export var bricks_left := 64

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass



func _on_Brick_broke(row: int):
	bricks_left -= 1
	if bricks_left == 0:
		emit_signal("last_brick_broke")
	emit_signal("brick_broke", row)
	pass # Replace with function body.

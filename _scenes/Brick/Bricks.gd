extends Node2D

signal brick_broke
signal last_brick_broke

export var bricks_left := 64

func _on_Brick_broke(row: int):
	bricks_left -= 1
	print("Bricks:", bricks_left)
	if bricks_left == 0:
		emit_signal("last_brick_broke")
	emit_signal("brick_broke", row)

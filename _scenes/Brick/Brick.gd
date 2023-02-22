extends StaticBody2D
class_name Brick

export var row := 0
export var color: Color = Color.white
signal broke

# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect.color = color


func break_brick():
	emit_signal("broke", row)
	queue_free()

extends Node

var num_bricks = 128
var num_bricks_per_row = 8
var num_rows = 2
var viewport_width = 720
var viewport_height = 1280
var row_spacing = 20
var color_index = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	print(get_viewport().size)
	var parent_node = get_node(".")

	if parent_node == null:
		print("ERROR: Node 'Level' not found")
		return

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

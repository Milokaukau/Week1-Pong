class_name Trail
extends Line2D

@export var MAX_LENGTH = 40
var point : Vector2

func _ready():
	clear_points()

func _process(delta):
	point = get_parent().position
	add_point(point)
	
	if (get_point_count()>MAX_LENGTH):
		remove_point(0)


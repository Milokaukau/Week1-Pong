extends StaticBody2D

var ball
var ball_pos
var dist

const PAD_SPEED = 330
var dir = Vector2(0,0)

func _ready():
	ball = $"../ball"

func _physics_process(delta):
	
	if(has_node("../ball")):
		ball_pos = ball.position
		dist = ball_pos.y - position.y 
	
		# Check if ball is above paddle
		if(dist<0):
			dir.y = -1
			move_and_collide(PAD_SPEED*dir*delta)
		else:
			dir.y = 1
			move_and_collide(PAD_SPEED*dir*delta)

func get_sprite():
	return $left_sprite

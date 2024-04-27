extends StaticBody2D

const PAD_SPEED = 330
var ball
var ball_pos
var ball_is_in_left_area : bool
var dist
var dir = Vector2(0,0)


func _physics_process(delta):
	
	# If ball exists
	if(ball != null):
		
		# Get distance between self and ball
		ball_pos = ball.position
		dist = ball_pos.y - position.y 
		
		# Check if ball is above paddle (when it's not in player's area)
		if !ball_is_in_left_area: 
			if(dist<0):
				dir.y = -1
				move_and_collide(PAD_SPEED*dir*delta)
			else:
				dir.y = 1
				move_and_collide(PAD_SPEED*dir*delta)

func get_sprite():
	return $left_sprite


func set_ball_null():
	ball = null


func set_ball(b):
	ball = b


func _on_root_ball_entered_left_area():
	ball_is_in_left_area = false


func _on_root_ball_exited_left_area():
	ball_is_in_left_area = true

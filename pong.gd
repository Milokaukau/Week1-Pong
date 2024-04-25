extends Node2D

# Member variables
var pad_size


# Constant fo pads speed
const PAD_SPEED = 330

# Constant for ball speed (pixels/sec)
const INITIAL_BALL_SPEED = 200

# Speed of the ball (pixels/sec)
var ball_speed = INITIAL_BALL_SPEED

var ball
var ball_dir
var ball_init_pos

var left_score : int
var right_score : int 

func _ready():
	left_score = 0
	right_score = 0
	$left_score.text = str(left_score)
	$right_score.text = str(right_score)
	
	# Initialize variables
	ball = $ball


func _process(delta):
	
	# Move the pads
#	if Input.is_action_pressed("left_move_up"):
#		$left_pad.move_and_collide(Vector2(0,-1)*PAD_SPEED*delta)
#	if Input.is_action_pressed("left_move_down"):
#		$left_pad.move_and_collide(Vector2(0,1)*PAD_SPEED*delta)
	if Input.is_action_pressed("right_move_up"):
		$right_pad.move_and_collide(Vector2(0,-1)*PAD_SPEED*delta)
	if Input.is_action_pressed("right_move_down"):
		$right_pad.move_and_collide(Vector2(0,1)*PAD_SPEED*delta)


func ball_collide_wall(collider):
	var new_ball_dir : Vector2
	
	# Flip direction vertically
	if(ball_dir.y > 0):
		new_ball_dir.y = -1
	else:
		new_ball_dir.y = 1
	
	new_ball_dir.x = ball_dir.x
	
	ball_dir = new_ball_dir.normalized()


func _on_ball_ball_out_left():
	$me_scored.play()
	right_score += 1
	$right_score.text = str(right_score)


func _on_ball_ball_out_right():
	$ai_scored.play()
	left_score += 1
	$left_score.text = str(left_score)

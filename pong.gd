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
	if Input.is_action_pressed("left_move_up"):
		var position = $left_pad.position.y - PAD_SPEED * delta
		$left_pad.position.y = clamp(position, 20, 380)
	if Input.is_action_pressed("left_move_down"):
		$left_pad.position.y += PAD_SPEED * delta
	if Input.is_action_pressed("right_move_up"):
		$right_pad.position.y -= PAD_SPEED * delta
	if Input.is_action_pressed("right_move_down"):
		$right_pad.position.y += PAD_SPEED * delta
	
	#if has_node("ball"):
	
	


func _on_right_pad_area_entered(area):
	if area == $ball:
		ball_collide_pad($right_pad)

func _on_left_pad_area_entered(area):
	if area == $ball:
		ball_collide_pad($left_pad)

func ball_collide_pad(collider):
	var new_ball_dir : Vector2
	
	# Flip direction horizontally
	if(ball_dir.x > 0):
		new_ball_dir.x = -1
	else:
		new_ball_dir.x = 1
	
	# Get distance between ball centre and pad centre
	# The further the ball is away from the pad centre, bigger the angle of bounce
	var dist = ball.position.y - collider.position.y
	var pad_height = collider.get_sprite().texture.get_size().y
	new_ball_dir.y = dist / pad_height
	
	# Set the new direction of the ball
	ball_dir = new_ball_dir.normalized()

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
	right_score += 1
	$right_score.text = str(right_score)


func _on_ball_ball_out_right():
	left_score += 1
	$left_score.text = str(left_score)

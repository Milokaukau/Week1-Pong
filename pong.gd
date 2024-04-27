extends Node2D

signal ball_queue_freed
signal ball_entered_player_area
signal ball_exited_player_area

signal ball_out_right
signal ball_out_left

# Member variables
var pad_size


# Constant fo pads speed
const PAD_SPEED = 330

# Constant for ball speed (pixels/sec)
const INITIAL_BALL_SPEED = 200

var ball_scene : PackedScene = preload("res://ball.tscn")
var ball
var left_score : int
var right_score : int 

var left_pad

var screen_size : Vector2 

func _ready():
	left_pad = $left_pad
	
	create_ball()
	
	screen_size = get_viewport_rect().size
	left_score = 0
	right_score = 0
	$left_score.text = str(left_score)
	$right_score.text = str(right_score)
	


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
	
	# Check ball out
	if(ball.position.x < 0):
		ball_out_left.emit()
	if(ball.position.x > screen_size.x):
		ball_out_right.emit()


func _on_ball_out_left():
	$me_scored.play()
	right_score += 1
	$right_score.text = str(right_score)
	
	ball.queue_free()
	ball_queue_freed.emit()

func _on_ball_out_right():
	$ai_scored.play()
	left_score += 1
	$left_score.text = str(left_score)
	
	ball.queue_free()
	ball_queue_freed.emit()

func _on_ball_queue_freed():
	left_pad.set_ball_null()
	create_ball()

func create_ball():
	ball = ball_scene.instantiate()
	add_child(ball, true)
	left_pad.set_ball(ball)
	


func _on_player_area_body_entered(body):
	if(body == ball):
		ball_entered_player_area.emit()


func _on_player_area_body_exited(body):
	if(body == ball):
		ball_exited_player_area.emit()

extends RigidBody2D

signal ball_out_right
signal ball_out_left

const INITIAL_BALL_SPEED = 200
var ball_speed = INITIAL_BALL_SPEED
var ball
var ball_dir
var ball_init_pos
var screen_size : Vector2

func _ready():
	ball_init_pos = Vector2($"../seperator".position.x, randf_range(100.0, 300.0))
	screen_size = get_viewport_rect().size
	visible = false
	position = ball_init_pos
	ball_dir = (Vector2(1,randf_range(-PI / 4, PI / 4))).normalized()
	visible = true

func _physics_process(delta):
	var collision = move_and_collide(ball_dir * ball_speed * delta)
		
	# Check ball out
	if(position.x < 0):
		queue_free()
		ball_out_left.emit()

	if(position.x > screen_size.x):
		queue_free()
		ball_out_right.emit()
	
	if collision:
		var collider = collision.get_collider()
		
		if(collider == $"../right_pad" or collider == $"../left_pad"):
			ball_dir = get_new_dir(collider)
			ball_speed *= 1.1
		else:
			ball_dir = ball_dir.bounce(collision.get_normal())
			ball_speed *= 1.1

func get_new_dir(collider):
	var new_ball_dir : Vector2
	
	# Flip direction horizontally
	if(ball_dir.x > 0):
		new_ball_dir.x = -1
	else:
		new_ball_dir.x = 1
	
	# Get distance between ball centre and pad centre
	# The further the ball is away from the pad centre, bigger the angle of bounce
	var dist = position.y - collider.position.y
	var pad_height = collider.get_sprite().texture.get_size().y
	new_ball_dir.y = dist / pad_height
	
	# Return the new direction of the ball
	return new_ball_dir.normalized()

extends RigidBody2D

const INITIAL_BALL_SPEED = 200
var ball_speed
var ball_dir
var ball_init_pos
var trailScene : PackedScene = preload("res://trail.tscn")
var trail

func _ready():
	visible = false
	
	# Add ball trail
	trail = trailScene.instantiate()
	add_child(trail)
	
	# Initialize ball position
	ball_init_pos = Vector2($"../seperator".position.x, randf_range(100.0, 300.0))
	position = ball_init_pos
	
	# Initialize ball movement
	ball_speed = INITIAL_BALL_SPEED
	ball_dir = (Vector2([1,-1].pick_random(),randf_range(-PI / 4, PI / 4))).normalized()
	
	visible = true


func _physics_process(delta):
	var collision = move_and_collide(ball_dir * ball_speed * delta)
	
	if collision:
		$boing.play()
		var collider = collision.get_collider()
		
		# If collided with paddle
		if(collider == $"../right_pad" or collider == $"../left_pad"):
			ball_dir = get_new_dir(collider)
		# If collided with wall
		else:
			ball_dir = ball_dir.bounce(collision.get_normal())
	
		# Make ball speed can only be in between 200 and 600
		ball_speed = clamp(ball_speed*1.1, 200, 600)


func get_new_dir(collider):
	var new_ball_dir : Vector2 = Vector2.ZERO
	var dist
	var pad_height
	
	# Flip direction horizontally
	if(ball_dir.x > 0):
		new_ball_dir.x = -1
	else:
		new_ball_dir.x = 1
	
	# Get distance between ball centre and pad centre
	# The further the ball is away from the pad centre, bigger the angle of bounce
	dist = position.y - collider.position.y
	pad_height = collider.get_sprite().texture.get_size().y
	new_ball_dir.y = dist / pad_height
	
	# Return the new direction of the ball
	return new_ball_dir.normalized()



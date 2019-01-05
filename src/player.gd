extends KinematicBody2D

# This demo shows how to build a kinematic controller.

# Member variables
<<<<<<< HEAD
export (int) var GRAVITY = 500.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
export (int) var FLOOR_ANGLE_TOLERANCE = 40
export (int) var WALK_FORCE = 600
export (int) var WALK_MIN_SPEED = 10
export (int) var WALK_MAX_SPEED = 200
export (int) var STOP_FORCE = 1300
export (int) var JUMP_SPEED = 200
export (int) var JUMP_MAX_AIRBORNE_TIME = 0.2
export (int) var WALL_JUMP_PUSH_MULTIPLIER = 1.5
=======
const GRAVITY = 1500.0 # pixels/second/second

# Angle in degrees towards either side that the player can consider "floor"
const FLOOR_ANGLE_TOLERANCE = 40
const WALK_FORCE = 800
const WALK_MIN_SPEED = 30
const WALK_MAX_SPEED = 400
const STOP_FORCE = 2000
const JUMP_SPEED = 1000
const JUMP_MAX_AIRBORNE_TIME = 0.4
>>>>>>> 9488755a1764c1a875aa9b4f5caf2499d42eb02d

export (int) var SLIDE_STOP_VELOCITY = 1.0 # one pixel/second
export (int) var SLIDE_STOP_MIN_TRAVEL = 1.0 # one pixel

var velocity = Vector2()
var on_air_time = 100
var jumping = false

var prev_jump_pressed = false
var prev_wall_hugged = false

func _physics_process(delta):
	# Create forces
	var force = Vector2(0, GRAVITY)
	
	var walk_left = Input.is_action_pressed("move_left")
	var walk_right = Input.is_action_pressed("move_right")
	var jump = Input.is_action_pressed("jump")
	var wall_touched = is_on_wall()
	
	var stop = true
	
	if walk_left:
		if velocity.x <= WALK_MIN_SPEED and velocity.x > -WALK_MAX_SPEED:
			force.x -= WALK_FORCE
			stop = false
	elif walk_right:
		if velocity.x >= -WALK_MIN_SPEED and velocity.x < WALK_MAX_SPEED:
			force.x += WALK_FORCE
			stop = false
	
	if stop:
		var vsign = sign(velocity.x)
		var vlen = abs(velocity.x)
		
		vlen -= STOP_FORCE * delta
		if vlen < 0:
			vlen = 0
		
		velocity.x = vlen * vsign
	
	# Integrate forces to velocity
	velocity += force * delta	
	# Integrate velocity into motion and move
	velocity = move_and_slide(velocity, Vector2(0, -1))
	
	if is_on_floor():
		on_air_time = 0
	
	if wall_touched:
		on_air_time = 0
		
	if jumping and velocity.y > 0:
		# If falling, no longer jumping
		jumping = false
	
	if on_air_time < JUMP_MAX_AIRBORNE_TIME and jump and not prev_jump_pressed and not jumping:
		# Jump must also be allowed to happen if the character left the floor a little bit ago.
		# Makes controls more snappy.
		
		if is_on_wall() or prev_wall_hugged:
			if walk_left:
				velocity.x = WALL_JUMP_PUSH_MULTIPLIER * JUMP_SPEED
				velocity.y = -JUMP_SPEED
			if walk_right:
				velocity.x = -WALL_JUMP_PUSH_MULTIPLIER * JUMP_SPEED
				velocity.y = -JUMP_SPEED
		else:
			velocity.y = -JUMP_SPEED
		
		jumping = true
	
	on_air_time += delta
	prev_jump_pressed = jump
	prev_wall_hugged = all_touched

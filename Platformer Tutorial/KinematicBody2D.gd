extends KinematicBody2D

# This is how we tell move_and_slide() which direction is up for platformers
const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 225
const JUMP_HEIGHT = -550

# A Vector2 is a special data type
# That holds an x and y value
# Rather then two separate variables
var motion = Vector2()

func _physics_process(delta):
	motion.y += GRAVITY
	var friction = true
	
	if Input.is_action_pressed("ui_right"):
		motion.x = min(motion.x+ACCELERATION, MAX_SPEED)
		$Sprite.flip_h = false;
		$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		motion.x = max(motion.x-ACCELERATION, -MAX_SPEED)
		$Sprite.flip_h = true;
		$Sprite.play("Run")
	else:
		$Sprite.play("Idle")
		friction = true

		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2) # AN easy way to do friction using linear interpolation)
	else:
		# If our y is less then 0 it means we are jumping because of how Godot handles coordinates
		if motion.y < 0:
			$Sprite.play("Jump")
		else:
			$Sprite.play("Falling")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
	
	# Resets our motion values so we dont build up gravity
	motion = move_and_slide(motion, UP)
	pass


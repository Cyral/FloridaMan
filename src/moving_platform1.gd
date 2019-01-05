extends KinematicBody2D

export (int) var SPEED = 100;
var direction = -1

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _physics_process(delta):
	# Called every frame. Delta is time since last frame.
	# Update game logic here.
	var velocity = Vector2(delta * SPEED * direction, 0)
	
	if move_and_collide(velocity):
		direction *= -1
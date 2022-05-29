extends KinematicBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var speed : int = 300
var jumpForce : int = 400
var gravity : int = 1200
var maxJumps : int = 3
var curJumps : int = 0
var dashForce : int = 1600

var vel : Vector2 = Vector2()
onready var sprite : Sprite = get_node("Leonardo")

# Called when the node enters the scene tree for the first time.
func _physics_process(delta):
	vel.x = 0
	
	if Input.is_action_pressed("move_left"):
		if Input.is_action_just_pressed("dash"):
			vel.x -= dashForce
		else:
			vel.x -= speed
	if Input.is_action_pressed("move_right"):
		if Input.is_action_just_pressed("dash"):
			vel.x += dashForce
		else:
			vel.x += speed
	
	vel = move_and_slide(vel, Vector2.UP)
	vel.y += gravity * delta
	
	if Input.is_action_just_pressed("jump") and curJumps <= maxJumps:
		vel.y -= jumpForce
		curJumps += 1
	
	if is_on_floor():
		curJumps = 0
	

	
	if vel.x < 0:
		sprite.flip_h = true
	elif vel.x > 0:
		sprite.flip_h = false

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

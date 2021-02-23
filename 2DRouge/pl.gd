extends KinematicBody2D


export (int) var speed = 200

var velocity = Vector2()

func get_input():

	
	velocity = Vector2()
	
	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	velocity = velocity.normalized() * speed
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	get_input()
	# $Sprite5.rotation = (get_global_mouse_position() - sprite.position).angle() # Might need to add + PI / 2 here
	velocity = move_and_slide(velocity)

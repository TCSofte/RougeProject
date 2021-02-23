extends KinematicBody2D


export (int) var speed = 400

var velocity = Vector2()
var Bullet = preload("res://Bullet.tscn")


func get_input():
	

	velocity = Vector2()
	

	if Input.is_action_pressed('ui_right'):
		velocity.x += 1
		$AnimatedSprite.flip_h=false
		$AnimatedSprite.play("walk")
	
	else:
		$AnimatedSprite.stop()
		
	if Input.is_action_pressed('ui_left'):
		velocity.x -= 1
		$AnimatedSprite.flip_h=true
		$AnimatedSprite.play("walk")
	

	
	if Input.is_action_pressed('ui_down'):
		velocity.y += 1
	if Input.is_action_pressed('ui_up'):
		velocity.y -= 1
	
		
	velocity = velocity.normalized() * speed

func _physics_process(delta):
	get_input()

	

	velocity = move_and_slide(velocity)

	
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	


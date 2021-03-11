extends RigidBody2D

signal hit

export var speed = 200 # How fast the player will move (pixels/sec).
var screen_size # Size of the game window.
var velocity = Vector2()
var gravity = 100
var flyvelocity = 700

func _ready():
	#screen_size = get_viewport_rect().size
	pass
	
func _input(event):
	if event is InputEventScreenTouch:
		linear_velocity.y = 150

func _process(delta):
	 # The player's movement vector.
	#velocity.y=gravity

	if Input.is_action_pressed("ui_right"):
		velocity.x += 1
	if Input.is_action_pressed("ui_left"):
		velocity.x -= 1
	if Input.is_action_pressed("ui_down"):
		velocity.y += 1
	if Input.is_action_pressed("ui_up"):
		velocity.y -= 1

	

	#move_and_slide(velocity)
	#position.x = clamp(position.x, 0, screen_size.x)
	#position.y = clamp(position.y, 0, screen_size.y)

	if velocity.x != 0:
		$AnimatedSprite.animation = "right"
		$AnimatedSprite.flip_v = false
		$AnimatedSprite.flip_h = velocity.x < 0
	if linear_velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = linear_velocity.y > 0


func start(pos):
	position = pos
	show()
	$CollisionShape2D.disabled = false


func _on_Player_body_entered(_body):
	hide() # Player disappears after being hit.
	emit_signal("hit")
	# Must be deferred as we can't change physics properties on a physics callback.
	$CollisionShape2D.set_deferred("disabled", true)

extends KinematicBody2D

# Node references
var player
onready var Bullet = preload("res://Bullet.tscn")
var ene = 8
signal killed
# Random number generator
var rng = RandomNumberGenerator.new()

# Movement variables
export var speed = 325
var direction : Vector2
var last_direction = Vector2(0, 1)
var bounce_countdown = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../pp11")
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	var movement = direction * speed * delta
	
	var collision = move_and_collide(movement)
	
	if collision != null and collision.collider.name != "Player":
		direction = direction.rotated(rng.randf_range(PI/4, PI/2))
		bounce_countdown = rng.randi_range(2, 5)
		
func _on_Timer_timeout():
	# Calculate the position of the player relative to the skeleton
	var player_relative_position = player.position - position
	
	if player_relative_position.length() <= 16:
		# If player is near, don't move but turn toward it
		direction = Vector2.ZERO
		last_direction = player_relative_position.normalized()
	elif player_relative_position.length() <= 400 and bounce_countdown == 0:
		# If player is within range, move toward it
		direction = player_relative_position.normalized()
	elif bounce_countdown == 0:
		# If player is too far, randomly decide whether to stand still or where to move
		var random_number = rng.randf()
		if random_number < 0.05:
			direction = Vector2.ZERO
		elif random_number < 0.1:
			direction = Vector2.DOWN.rotated(rng.randf() * 2 * PI)
	
	# Update bounce countdown
	if bounce_countdown > 0:
		bounce_countdown = bounce_countdown - 1


func _on_Timerrocket_timeout():
	var b = Bullet.instance()
	b.shoot($Position2D.global_position, $Position2D.rotation)
	get_parent().add_child(b)
	var b1 = Bullet.instance()
	b1.shoot($Position2D2.global_position, $Position2D2.rotation)
	get_parent().add_child(b1)
	var b2 = Bullet.instance()
	b2.shoot($Position2D3.global_position, $Position2D3.rotation)
	get_parent().add_child(b2)
	var b3 = Bullet.instance()
	b3.shoot($Position2D4.global_position, $Position2D4.rotation)
	get_parent().add_child(b3)


func _on_Area2D_area_entered(area):
	if area.is_in_group("sword") or area.is_in_group("Bullet"):
		ene-=1
		print('ene',ene)
		if ene<=0:
			emit_signal("killed")
			queue_free()

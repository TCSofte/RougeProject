extends KinematicBody2D

# Node references
var player
signal killed
var ene = 4
# Random number generator
var rng = RandomNumberGenerator.new()

# Movement variables
export var speed = 325
var direction : Vector2
var last_direction = Vector2(0, 1)
var bounce_countdown = 0
var colpito = false
var killed = false
# Called when the node enters the scene tree for the first time.
func _ready():
	player = get_node("../pp11")
	rng.randomize()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _physics_process(delta):
	if colpito == false and killed == false:
		var movement = direction * speed * delta
		
		var collision = move_and_collide(movement)
		
		
		if collision != null and collision.collider.name != "Player":
			$AnimatedSprite.play("volo")
			# See the note below about boolean assignment
			
			direction = direction.rotated(rng.randf_range(PI/4, PI/2))
			$AnimatedSprite.flip_h = direction.x > 0
			bounce_countdown = rng.randi_range(2, 5)
		
func _on_Timer_timeout():
	if colpito == false and killed == false:
		# Calculate the position of the player relative to the slime
		var player_relative_position = player.position - position
		
		if player_relative_position.length() <= 16:
			# If player is near, don't move but turn toward it
			direction = Vector2.ZERO
			last_direction = player_relative_position.normalized()
		elif player_relative_position.length() <= 300 and bounce_countdown == 0:
			# If player is within range, move toward it
			direction = player_relative_position.normalized()
			$AnimatedSprite.flip_h = direction.x > 0
		elif bounce_countdown == 0:
			# If player is too far, randomly decide whether to stand still or where to move
			var random_number = rng.randf()
			if random_number < 0.05:
				direction = Vector2.ZERO
			elif random_number < 0.1:
				direction = Vector2.DOWN.rotated(rng.randf() * 2 * PI)
				$AnimatedSprite.flip_h = direction.x > 0
		
		# Update bounce countdown
		if bounce_countdown > 0:
			bounce_countdown = bounce_countdown - 1


func _on_Area2D_area_entered(area):
	if area.is_in_group("sword") or area.is_in_group("Bullet") or area.is_in_group("parata") and killed == false:
		colpito = true
		$AnimatedSprite.play("colpita")
		direction = direction.rotated(rng.randf_range(PI/4, PI/2))
		$AnimatedSprite.flip_h = direction.x > 0
		bounce_countdown = rng.randi_range(2, 5)
		ene-=1
		if ene<=0:
			$AnimatedSprite.play("morte")
			if killed == false:
				emit_signal("killed")
				killed= true
	if area.is_in_group("scudo") and killed == false:		
		direction = direction.rotated(rng.randf_range(PI/4, PI/2))
		$AnimatedSprite.flip_h = direction.x > 0
		bounce_countdown = rng.randi_range(2, 5)

func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="colpita":
		$AnimatedSprite.play("volo")
		colpito = false
	if $AnimatedSprite.animation=="morte":
			queue_free()

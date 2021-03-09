extends KinematicBody2D

var collision
var de
var speed = 750
var velocity = Vector2()
onready var particelleslime = preload("res://particelleslime.tscn")
func shoot(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)
	
func shoot22(pos):
	position = pos
	velocity = Vector2(speed, 0)

func _physics_process(delta):
	de=delta
	collision = move_and_collide(velocity * delta)
	if collision:
		var b = particelleslime.instance()
		b.position = global_position
		get_parent().call_deferred("add_child", b)
		queue_free()
#		velocity = velocity.bounce(collision.normal)
#		if collision.collider.has_method("hit"):
#			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func handle_collision(collision : KinematicCollision2D):
	velocity = velocity.bounce(collision.normal)


func _on_Area2D_area_entered(area):
	
	queue_free()

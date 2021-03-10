extends KinematicBody2D

var collision
var de
var speed = 750
var velocity = Vector2()
onready var particelleslime = preload("res://particelleslime.tscn")
onready var Bullet = preload("res://Bullet.tscn")
func shoot(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)
	
func shoot22(pos):
	position = pos
	velocity = Vector2(speed, 0)
	
func shootrev(pos, vel):
	position = pos
	velocity = vel	

func _physics_process(delta):
	de=delta
	collision = move_and_collide(velocity * delta)
	if collision:
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		#var b = particelleslime.instance()
		#b.position = global_position
		#get_parent().call_deferred("add_child", b)
		queue_free()
#		velocity = velocity.bounce(collision.normal)
#		if collision.collider.has_method("hit"):
#			collision.collider.hit()

func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func handle_collision(collision : KinematicCollision2D):
	velocity = velocity.bounce(collision.normal)


func _on_Area2D_area_entered(area):
	if area.is_in_group("parata") :
		$CollisionShape2D.disabled = true
		$Area2D/CollisionShape2D.disabled = true
		var b = Bullet.instance()
		b.shootrev(global_position, Vector2(velocity.x*-1, velocity.y*-1))
		get_parent().add_child(b)
		
		

		#velocity.x= velocity.x*-1
		#velocity.y= velocity.y*-1
		return
		
		#velocity = velocity.bounce(collision.normal)
		
	if area.is_in_group("bordo") :
		var b = particelleslime.instance()
		b.position = global_position
		get_parent().call_deferred("add_child", b)
		queue_free()


func _on_Timer_timeout():
	queue_free()
	var b = Bullet.instance()
	b.shootrev(global_position, Vector2(velocity.x*-1, velocity.y*-1))
	get_parent().add_child(b)

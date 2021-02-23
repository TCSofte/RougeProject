extends KinematicBody2D

export (int) var speed = 400

var velocity = Vector2()
onready var Bullet = preload("res://Bullet.tscn")
var isAttacking = false
var can_drop_bomb = true
onready var tilemap = get_node("/root//Level1/TileMap2")
onready var drop_bomb_cooldown = get_node("DropBombCooldown")


func get_input():
	
#
	
#	var m = get_global_mouse_position()
#	var aim_speed = deg2rad(3)
#	if $Sprite5.get_angle_to(m) > 0:
#		$Sprite5.rotation += aim_speed
#	else:
#		$Sprite5.rotation -= aim_speed
	
		
	$Braccia.look_at(get_global_mouse_position())
	#$braccioscudo.look_at(get_global_mouse_position())
	
	velocity = Vector2()
	
	
#	if Input.is_action_pressed('ui_up'):
#		velocity = Vector2(-speed/3, 0).rotated(rotation)
#	if Input.is_action_pressed('ui_down'):
#		velocity = Vector2(speed, 0).rotated(rotation)
  
	
	if Input.is_action_pressed('ui_right') and isAttacking==false:
		velocity.x += 1
		$Exhaust2.emitting = false
		$Exhaust2.emitting = false
		$Exhaust.emitting = true
	if Input.is_action_pressed('ui_left') and isAttacking==false:
		$Exhaust.emitting = false
		$Exhaust2.emitting = true
		velocity.x -= 1
	if Input.is_action_pressed('ui_down') and isAttacking==false:
		velocity.y += 1
	if Input.is_action_pressed('ui_up') and isAttacking==false:
		velocity.y -= 1
		
	
		
		
		
	if Input.is_action_just_pressed('mouse_click'):
		
		isAttacking=true
		$AnimatedSprite.play("Attack")
		#shoot()	
		
	velocity = velocity.normalized() * speed
	
	


func _physics_process(delta):
	get_input()

	
	#var dir = get_global_mouse_position() - global_position
	# $Sprite5.rotation = (get_global_mouse_position() - sprite.position).angle() # Might need to add + PI / 2 here
	velocity = move_and_slide(velocity)
	# print(get_global_mouse_position())
#	if dir.length() > 5:
#	   rotation = dir.angle()
#	   velocity = move_and_slide(velocity)
	if (velocity.x != 0  or velocity.y != 0) and isAttacking==false:
		$AnimatedSprite.play("walk")

		$AnimatedSprite.flip_v = false
		# See the note below about boolean assignment
		$AnimatedSprite.flip_h = velocity.x < 0
	else:
		if isAttacking==false:
			$AnimatedSprite.play("Idle")
#	elif velocity.y != 0:
#
#		$AnimatedSprite.flip_v = velocity.y > 0
		
	var aa = get_global_mouse_position()
#	if(aa.y>=280):
#
#		$Sprite4.flip_h = false
#		$Sprite6.flip_h = false
#
#	elif(aa.y<=280):
#		$Sprite4.flip_h = true
#		$Sprite6.flip_h = true
	
		
#	if(aa.x<=380):
#		print('bmbmnmbmmnm')
#		$Sprite6.visible  = true
#	elif(aa.x>=380):
#		print('bmbmnmbmmnm')
#		$Sprite6.visible  = false
func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bullet.instance()
	print('$aaaaaaaaaaaaaaaaaaa',$Braccia/Muzzle.global_position)
	print('aaaaaaaaaaaaaaa',global_position)
	b.shoot22($Braccia/Muzzle.global_position)
	#b.shoot($braspada/Muzzle.global_position, $braspada.rotation)

	get_parent().add_child(b)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.
	

func _on_Area2D_area_entered(area):
#	var collision_shape = area.get_node("CollisionShape2D")
#	var size = collision_shape.shape.extents*2
#
#	var view_size = get_viewport_rect().size
#	if size.y < view_size.y:
#		size.y = view_size.y
#
#	if size.x < view_size.x:
#		size.x = view_size.x
#
#	var cam = $Camera2D
#	cam.limit_top = collision_shape.global_position.y - size.y/2
#	cam.limit_left = collision_shape.global_position.x - size.x/2
#
#	cam.limit_bottom = cam.limit_top + size.y
#	cam.limit_right = cam.limit_left + size.x
	pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.animation=="Attack":
		$Area2D/CollisionShape2D.disabled=true
		isAttacking=false


func _on_AnimatedSprite_frame_changed():
	
	if $AnimatedSprite.animation=="Attack" and  $AnimatedSprite.get_frame()==6:
		$Area2D/CollisionShape2D.disabled=false



func _on_drop_bomb_cooldown_timeout():
	can_drop_bomb = true
	print('_on_drop_bomb_cooldown_timeout')

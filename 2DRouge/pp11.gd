extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
onready var Bullet = preload("res://Bullet.tscn")
var isAttacking = false
var isrolling = false
var can_drop_bomb = true
onready var drop_bomb_cooldown = get_node("DropBombCooldown")
onready var _transition_rect := get_node("../SceneTransitionRect")
onready var bomb = preload("res://Bomba22.tscn")
var ene = 3
var die = false
func get_input():
	
#
	
#	var m = get_global_mouse_position()
#	var aim_speed = deg2rad(3)
#	if $Sprite5.get_angle_to(m) > 0:
#		$Sprite5.rotation += aim_speed
#	else:
#		$Sprite5.rotation -= aim_speed
	
		
	$Sprite.look_at(get_global_mouse_position())
	
	#$braccioscudo.look_at(get_global_mouse_position())
	
	velocity = Vector2()
	
	
#	if Input.is_action_pressed('ui_up'):
#		velocity = Vector2(-speed/3, 0).rotated(rotation)
#	if Input.is_action_pressed('ui_down'):
#		velocity = Vector2(speed, 0).rotated(rotation)
   
	if die == false:
		if Input.is_action_pressed('ui_right') and isAttacking==false:
			velocity.x += 1

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
		
		if Input.is_action_pressed('roll') and isAttacking==false:
			$Sprite.visible = false
			$AnimatedSprite.play("roll")
			isrolling=true
			velocity.y -= 1
			
			
		
			
		if Input.is_action_just_pressed('bomb') and can_drop_bomb==true:
			placebomb()	
			
		if Input.is_action_just_pressed('mouse_click'):
			
			#isAttacking=true
			#$AnimatedSprite.play("Attack")
			shoot()	
			
		velocity = velocity.normalized() * speed
	
	


func _physics_process(delta):
	
	if die == false:
		get_input()

		
		#var dir = get_global_mouse_position() - global_position
		# $Sprite5.rotation = (get_global_mouse_position() - sprite.position).angle() # Might need to add + PI / 2 here
		
		# print(get_global_mouse_position())
	#	if dir.length() > 5:
	#	   rotation = dir.angle()
	#	   velocity = move_and_slide(velocity)
		if (velocity.x != 0  or velocity.y != 0) and isAttacking==false and isrolling==false:
			$AnimatedSprite.play("walk")

			$AnimatedSprite.flip_v = false
			# See the note below about boolean assignment
			$AnimatedSprite.flip_h = velocity.x < 0
			
			

		
		elif  (velocity.x == 0  and velocity.y == 0) and isAttacking==false and isrolling==false:
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
		velocity = move_and_slide(velocity)
func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bullet.instance()
	#b.shoot22($Sprite/mani/Muzzle.global_position)
	b.shoot($Sprite/mani/Muzzle.global_position, $Sprite.rotation)
	get_parent().add_child(b)
	
func placebomb():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = bomb.instance()
	#b.shoot22($Sprite/mani/Muzzle.global_position)
	b.position  = $PositionBomba.global_position
	get_parent().add_child(b)	
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Sprite/mani/Area2D2/CollisionPolygon2D.disabled = true
	

func _on_Area2D_area_entered(area):
#	var collision_shape = area.get_node("CollisionShape2D")
#	var size = collision_shape.shape.extents*2
	if area.is_in_group("doordx"):
	#	_transition_rect.transition_to()
		position.x+= 610
	if area.is_in_group("doorsx"):
		position.x-= 610
	if area.is_in_group("doorup"):
		position.y-= 450
	if area.is_in_group("doordw"):
		position.y+= 450
	if area.is_in_group("enemy"):
		ene-=1
		print('ene',ene)
		if ene==2:get_node("../CanvasLayer/TextureRect4").visible = false
		if ene==1:get_node("../CanvasLayer/TextureRect2").visible = false
		if ene==0:get_node("../CanvasLayer/TextureRect3").visible = false
		if ene<=0:
			die = true
			$Sprite.visible = false
			$AnimatedSprite.play("die")
			
			
	
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
	if $AnimatedSprite.animation=="roll":
		isrolling=false
		$Sprite.visible = true
	if $AnimatedSprite.animation=="die":
		get_node("../CanvasLayer/Label").visible = true
		


func _on_AnimatedSprite_frame_changed():
	
	if $AnimatedSprite.animation=="Attack" and  $AnimatedSprite.get_frame()==6:
		$Area2D/CollisionShape2D.disabled=false



func _on_drop_bomb_cooldown_timeout():
	can_drop_bomb = true
	print('_on_drop_bomb_cooldown_timeout')

extends KinematicBody2D

export (int) var speed = 200

var velocity = Vector2()
onready var Bullet = preload("res://Bullet.tscn")
onready var Puntina = preload("res://Puntina.tscn")
onready var Rope = preload("res://LongPieceRope/Rope.tscn")
onready var jojo = preload("res://jojo.tscn")

var RopeRope
var jojojojo
var jojojojotrue = false
var isAttacking = false
var isrolling = false
var can_drop_bomb = true
var left = false
var right = false
var lollo = false
var grap = false
var tograp = false
var pieces = 0
signal grapend
var distance
var target = Vector2()
enum States {spada, scettro, rampino}
var _state : int = States.scettro
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
			$Polveresx.visible = true
			$Polveredx.visible = false
#			$Exhaust2.emitting = false
#			$Exhaust.emitting = true
			velocity.x += 1
			if isrolling==true:
				velocity.x += 145
			right = true
			left = false
	
			
		if Input.is_action_pressed('ui_left') and isAttacking==false:
			$Polveresx.visible = false
			$Polveredx.visible = true
#			$Exhaust.emitting = false
#			$Exhaust2.emitting = true
			velocity.x -= 1
			left = true
			right = false

		if Input.is_action_pressed('ui_down') and isAttacking==false:
			velocity.y += 1
			
		if Input.is_action_pressed('ui_up') and isAttacking==false:
			velocity.y -= 1
		
		if Input.is_action_pressed('roll') and isAttacking==false:
			if Input.is_action_pressed('ui_right') and isAttacking==false:
				velocity.x += 115
			if Input.is_action_pressed('ui_left') and isAttacking==false:
				velocity.x -= 115
			
			$Sprite.visible = false
			$AnimatedSprite.play("roll")
			isrolling=true
			
		if Input.is_action_just_pressed('bomb') and can_drop_bomb==true:
			placebomb()	
				
		
#		if Input.is_action_just_pressed('weapon') and can_drop_bomb==true:
#			if _state == States.scettro:
#				_state = States.spada
#				$Sprite/mani.play("Attaccospada")
#				$Sprite/mani/Area2D2/CollisionPolygon2D.disabled = false
#				$Sprite/mani/Area2D3/CollisionShape2D.disabled = true
#				get_node("../CanvasLayer/TextureRect11").visible = true
#				get_node("../CanvasLayer/TextureRect10").visible = false
#				get_node("../CanvasLayer/TextureRect8").visible = false
#				return
#			if _state == States.spada:
#				_state = States.rampino
#				$Sprite/mani.play("Rampino")
#				$Sprite/mani/Area2D2/CollisionPolygon2D.disabled = true
#				$Sprite/mani/Area2D3/CollisionShape2D.disabled = true
#				get_node("../CanvasLayer/TextureRect10").visible = false
#				get_node("../CanvasLayer/TextureRect11").visible = false
#				get_node("../CanvasLayer/TextureRect8").visible = true
#				return
#			if _state == States.rampino:
#				_state = States.scettro
#				$Sprite/mani.play("Attaccoscettro")
#				$Sprite/mani/Area2D3/CollisionShape2D.disabled = false
#				$Sprite/mani/Area2D2/CollisionPolygon2D.disabled = true
#				get_node("../CanvasLayer/TextureRect10").visible = true
#				get_node("../CanvasLayer/TextureRect11").visible = false
#				get_node("../CanvasLayer/TextureRect8").visible = false
#				return
			
			
			
		if Input.is_action_just_pressed('mouse_click') :
			if _state == States.scettro:
				$Sprite/mani.play("Attaccoscettro")
				$Sprite/mani.set_frame(0)
			if _state == States.spada:
				$Sprite/mani.play("Attaccospada")
				$Sprite/mani.set_frame(0)
				$Sprite/mani/Area2D4/CollisionShape2D.disabled = false
			#isAttacking=true
			#$AnimatedSprite.play("Attack")
			shoot()	
			
		if grap == true and lollo==true:	
			if Input.is_action_just_released('mouse_click') and isAttacking==false and _state == States.rampino:
				lollo = false
				grap = false
				tograp = false
				print('grapendgrapendgrapendgrapend')
				get_node("../CanvasLayer/TextureRect12").visible = false
				get_node("../CanvasLayer/Label2").visible = false
#				emit_signal("grapend")
				get_node("../Rope").queue_free()
				
				
			
		if grap == true:
			if Input.is_action_pressed('mouse_click') and isAttacking==false and _state == States.rampino:
				target =  RopeRope.global_position
				velocity = position.direction_to(target) * 1000
				velocity = move_and_slide(velocity)
#				lollo = true
				
#		if tograp == true:
#			target =  RopeRope.global_position
#			velocity = position.direction_to(target) * 1000
#			velocity = move_and_slide(velocity)
#			lollo = true
		
		
		if Input.is_action_just_pressed('scudo') and _state == States.scettro:
			
			$Sprite/mani/Area2D/CollisionShape2D2.disabled = true
			$Sprite/mani/Area2D3/CollisionShape2D.disabled = false
#				$Sprite/mani/Area2D3/AnimatedSprite2.visible = true
			$Timer.start()
			
			
		
		velocity = velocity.normalized() * speed
			
		
	
	


func _physics_process(delta):
	
	if die == false:
		get_input()
		if $Sprite/mani/RayCast2D.is_colliding():
			var origin = $Sprite/mani/RayCast2D.global_transform.origin
			var collision_point = $Sprite/mani/RayCast2D.get_collision_point()
			distance = origin.distance_to(collision_point)
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
				$Polveresx.visible = false
				$Polveredx.visible = false
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
	if _state == States.scettro:
		var b = Bullet.instance()
		#b.shoot22($Sprite/mani/Muzzle.global_position)
		b.shoot($Sprite/mani/Muzzle.global_position, $Sprite.rotation)
		get_parent().add_child(b)
	if _state == States.rampino and lollo == false and grap == false:
#		var b = Rope.instance()
#		b.pieces=int(round(distance))/15
#		#b.shoot22($Sprite/mani/Muzzle.global_position)
#		b.connect('lastpiece', 	get_parent(), '_on_Rope_lastpiece')
#		b.shoot($Sprite/mani/Muzzle.global_position, $Sprite.rotation)
#		get_parent().add_child(b)
		pieces=int(round(distance))/15
		if pieces >=3:
			lollo = true
			if jojojojotrue == false:
				jojojojo = jojo.instance()
				jojojojo.position= global_position
				get_parent().add_child(jojojojo)
				jojojojotrue = true
			RopeRope = Rope.instance()
			RopeRope.pieces=pieces
			
			#b.shoot22($Sprite/mani/Muzzle.global_position)
			RopeRope.connect('lastpiece', 	self, '_on_Rope_lastpiece')
			RopeRope.connect('grap', 	self, '_on_Rope_grap')
			
	#		RopeRope.position=$Sprite/mani/Muzzle.global_position
		
			RopeRope.shoot($Sprite/mani/Muzzle.global_position, $Sprite.rotation)
			get_parent().add_child(RopeRope)
	
func placebomb():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = bomb.instance()
	#b.shoot22($Sprite/mani/Muzzle.global_position)
	
	if right == true:
		b.position  = $PositionBomba.global_position
	if left == true:
		b.position  = $Position2D2.global_position
	get_parent().add_child(b)	
	
	
# Called when the node enters the scene tree for the first time.
func _ready():
	#Input.set_mouse_mode(Input.MOUSE_MODE_HIDDEN)
	$Sprite/mani/Area2D2/CollisionPolygon2D.disabled = true
	$Sprite/mani/Area2D4/CollisionShape2D.disabled = true
	
	

func _on_Area2D_area_entered(area):
#	var collision_shape = area.get_node("CollisionShape2D")
#	var size = collision_shape.shape.extents*2
	if area.is_in_group("doordx"):
	#	_transition_rect.transition_to()
		position.x+= 620
	if area.is_in_group("doorsx"):
		position.x-= 620
	if area.is_in_group("doorup"):
		position.y-= 460
	if area.is_in_group("doordw"):
		position.y+= 460
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
	if area.is_in_group("ene"):		
			ene+=1
			get_node("../CanvasLayer/TextureRect4").visible = true
			get_node("../CanvasLayer/TextureRect2").visible = true
			get_node("../CanvasLayer/TextureRect3").visible = true
			if ene==2:get_node("../CanvasLayer/TextureRect4").visible = false
			if ene==1:get_node("../CanvasLayer/TextureRect2").visible = false
			if ene==0:get_node("../CanvasLayer/TextureRect3").visible = false
	
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
		get_node("../CanvasLayer/Button").visible = true
	
		
		


func _on_AnimatedSprite_frame_changed():
	
	if $AnimatedSprite.animation=="Attack" and  $AnimatedSprite.get_frame()==6:
		$Area2D/CollisionShape2D.disabled=false



func _on_drop_bomb_cooldown_timeout():
	can_drop_bomb = true


func _on_Timer_timeout():
	$Sprite/mani/Area2D3/CollisionShape2D.disabled = true
	$Sprite/mani/Area2D/CollisionShape2D2.disabled = false
	$Sprite/mani/Area2D3/AnimatedSprite2.visible = false


	
func _on_Area2D3_area_entered(area):

	if area.is_in_group("enemy") :
		print('_on_Area2D3_area_entered_on_Area2D3_area_entered')
		$Sprite/mani.play("default")
		$Sprite/mani.set_frame(0)


func _on_mani_animation_finished():
	if $Sprite/mani.animation=="Attaccospada":
		$Sprite/mani/Area2D4/CollisionShape2D.disabled = true

func _on_Rope_lastpiece():
	print('RopeRope.lastpiecepath',	RopeRope.lastpiecepath)
#	if pieces >=3 and RopeRope.lastpiecepath !=null:
#
#		jojojojo.node_a = $StaticBody2D.get_path()
##		$PinJoint2D.node_b = RopeRope.get_path()
##		$PinJoint2D.node_b = RopeRope.lastpiecepath
#		jojojojo.node_b = RopeRope.lastpiecepath

	

#func _on_Area2D_body_entered(body):
#	if body.is_in_group("bordo") :
#		lollo = false
#		grap = false
#		tograp = false


func _on_Rope_grap():
		grap = true
		lollo = true
		tograp = true
		get_node("../CanvasLayer/TextureRect12").visible = true
		get_node("../CanvasLayer/Label2").visible = true
		$PinJoint2D.node_b = $StaticBody2D.get_path()
		$PinJoint2D.node_b = RopeRope.lastpiecepath
		

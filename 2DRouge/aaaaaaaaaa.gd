extends KinematicBody2D

var Bullet = preload("res://Bullet.tscn")
onready var bomb_scene = preload("res://scenes/bomb.tscn")
onready var tilemap = get_node("/root/Level1/TileMap2")
var speed = 200
var velocity = Vector2()
var dir

func get_input():
	# Add these actions in Project Settings -> Input Map.
	velocity = Vector2()
	if Input.is_action_pressed('ui_down'):
		velocity = Vector2(-speed/3, 0).rotated(rotation)
	if Input.is_action_pressed('ui_up'):
		velocity = Vector2(speed, 0).rotated(rotation)
		
		
	
		
		
	if Input.is_action_just_pressed('mouse_click'):
		shoot()

func shoot():
	# "Muzzle" is a Position2D placed at the barrel of the gun.
	var b = Bullet.instance()

	b.shoot($Muzzle.global_position, rotation)
	get_parent().add_child(b)

func _physics_process(delta):
	get_input()
	var dir = get_global_mouse_position() - global_position
	# Don't move if too close to the mouse pointer.
	if dir.length() > 5:
		rotation = dir.angle()
		velocity = move_and_slide(velocity)

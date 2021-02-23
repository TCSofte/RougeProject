extends Node2D

func _ready():
	
	var player = get_node("Main/KinematicBody2D")

	player.connect("moving", get_node("Main/Camera2D"),"update_camera")
	set_process_input(true)
	

func _input(e):
	if Input.is_action_just_released("ui_cancel"):
		get_tree().quit()

func on_enemy_hit():
	print('enemy was hit, do something')
	
func on_hero_attack():
	print("hero attacked")

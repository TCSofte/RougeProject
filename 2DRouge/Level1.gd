extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var score = 0
var key = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass	

func update_score(score):
	$coins.text = str(score)


func _on_coin_picked():
	score = score+1
	$CanvasLayer/coins.text = str(score)





func _on_chiave_keyPicked():
	key = key+1
	$CanvasLayer/key.text = str(key)





func _on_Cuore_picked():
	pass # Replace with function body.



	


func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		$CanvasModulate.visible = true
		$pp11/Light2D2.visible = true


func _on_Area2D3_area_entered(area):
	if area.is_in_group("player"):
		$CanvasModulate.visible = false
		$pp11/Light2D2.visible = false


func _on_Button_pressed():
	get_tree().reload_current_scene()

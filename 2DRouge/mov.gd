extends RigidBody2D

onready var chiave = preload("res://chiave.tscn")
var spawn = true
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_area_entered(area):
	if area.is_in_group("player"):
		$AnimatedSprite.play("default")
		print('_on_Area2D_area_entered')
		if spawn==true:
			var b = chiave.instance()
			b.connect('keyPicked', 	get_parent(), '_on_chiave_keyPicked')
			b.position = global_position
			get_parent().add_child(b)
			spawn=false


func _on_Area2D_area_shape_entered(area_id, area, area_shape, self_shape):
	if area.is_in_group("player"):
		$AnimatedSprite.play("default")
		print('_on_Area2D_area_shape_entered')

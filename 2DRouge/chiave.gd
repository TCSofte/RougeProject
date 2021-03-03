extends Area2D

signal keyPicked
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_chiave_body_entered(body):
	if body.is_in_group("player"):  
		emit_signal("keyPicked")
		$AnimatedSprite.play("NewAnim")
		#queue_free()



func _on_AnimatedSprite_animation_finished():
	queue_free()

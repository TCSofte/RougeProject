extends Area2D

signal keyPicked
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimatedSprite.play("NewAnim")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_chiave_body_entered(body):
	if body.is_in_group("player"):  
		emit_signal("keyPicked")
		queue_free()




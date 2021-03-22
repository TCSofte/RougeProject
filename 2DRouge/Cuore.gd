extends Area2D

signal picked
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	#$AnimatedSprite.play("default")
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation()=="Raccolta":
		queue_free()


func _on_Cuore_picked():
	pass # Replace with function body.


func _on_Cuore_body_entered(body):
	if body.is_in_group("player"):  
		emit_signal("picked")
		$AnimatedSprite.play("Raccolta")


#func _on_Cuore_area_entered(area):
#	pass # Replace with function body.

extends Node




func _ready():
	$AnimatedSprite.play("default")




func _on_AnimatedSprite_animation_finished():
	queue_free()

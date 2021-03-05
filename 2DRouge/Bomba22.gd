extends RigidBody2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	$Areadamage/Collisiondamage.disabled = true


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Area2D_body_entered(body):
	if body.is_in_group("player"):  
		$AnimatedSprite.play("Raccolta")
	if body.is_in_group("Bullet"):  
		$AnimatedSprite.play("Esplosione")


func _on_AnimatedSprite_animation_finished():
	if $AnimatedSprite.get_animation()=="Esplosione":
		queue_free()
	if $AnimatedSprite.get_animation()=="Caricamento":
		$Areadamage/Collisiondamage.disabled = false
		$AnimatedSprite.play("Esplosione")
	


func _on_Timer_timeout():
	$AnimatedSprite.play("Caricamento")

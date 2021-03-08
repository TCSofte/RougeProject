extends Area2D

var open = 0
export  var unlock = 3
# Declare member variables here. Examples:
# var a = 2
# var b = "text"

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open>=unlock:
		$AnimatedSprite.play("default")
		$CollisionShape2D.disabled = false
		open = 0









func _on_piccolonemico5_killed():
	open = open+1


func _on_piccolonemico6_killed():
	open = open+1


func _on_piccolonemico4_killed():
	open = open+1


func _on_piccolonemico3_killed():
	open = open+1


func _on_slime3_killed():
	open = open+1


func _on_slime2_killed():
	open = open+1


func _on_slime4_killed():
	open = open+1

extends Area2D

var open = 0
# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var coin = preload("res://coin.tscn")
onready var chiave = preload("res://chiave.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open>=5:
		$AnimatedSprite.play("default")
		$CollisionShape2D.disabled = false
		var c1 = coin.instance()
		c1.connect('picked', 	 get_parent(), '_on_coin_picked')
		c1.position = $Positionc1.global_position
		get_parent().add_child(c1)
		var c2 = coin.instance()
		c2.connect('picked', 	 get_parent(), '_on_coin_picked')
		c2.position = $Positionc2.global_position
		get_parent().add_child(c2)

		var b = chiave.instance()
		b.connect('keyPicked', 	get_parent(), '_on_chiave_keyPicked')
		b.position = $Position.global_position
		get_parent().add_child(b)
		open = 0



func _on_piccolonemico_killed():
	open = open+1
	print('open',open)


func _on_slime_killed():
	open = open+1
	print('open',open)

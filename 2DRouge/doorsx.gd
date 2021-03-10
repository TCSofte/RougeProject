extends Area2D

var open = 0
export  var unlock = 3

var rng
onready var coin = preload("res://coin.tscn")
onready var chiave = preload("res://chiave.tscn")
onready var Cuore = preload("res://Cuore.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	rng = RandomNumberGenerator.new()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if open>=unlock:
		$AnimatedSprite.play("default")
		$CollisionShape2D.disabled = false
		rng.randomize()
		var rand_index = rng.randi_range(1, 3)
		
		print('rand_index',rand_index)
		match rand_index:
			1:
				var c1 = coin.instance()
				c1.connect('picked', 	 get_parent(), '_on_coin_picked')
				c1.position = $Positionc1.global_position
				get_parent().add_child(c1)
			2:
				var c1 = Cuore.instance()
				c1.connect('picked', 	 get_parent(), '_on_Cuore_picked')
				c1.position = $Positionc1.global_position
				get_parent().add_child(c1)
			3:
				var c1 = chiave.instance()
				c1.connect('keyPickedd', 	 get_parent(), '_on_chiave_keyPicked')
				c1.position = $Positionc1.global_position
				get_parent().add_child(c1)
		
	
#		var c2 = Cuore.instance()
#		c2.connect('picked', 	 get_parent(), '_on_Cuore_picked')
#		c2.position = $Positionc2.global_position
#		get_parent().add_child(c2)
#
#		var b = chiave.instance()
#		b.connect('keyPicked', 	get_parent(), '_on_chiave_keyPicked')
#		b.position = $Position.global_position
#		get_parent().add_child(b)
		open = 0



func _on_piccolonemico_killed():
	open = open+1
	print('open',open)


func _on_slime_killed():
	open = open+1
	print('open',open)




func _on_piccolonemico3_killed():
	open = open+1
	print('open',open)


func _on_piccolonemico4_killed():
	open = open+1
	print('open',open)


func _on_piccolonemico5_killed():
	open = open+1
	print('open',open)


func _on_piccolonemico6_killed():
	open = open+1
	print('open',open)


func _on_slime3_killed():
	open = open+1


func _on_slime2_killed():
	open = open+1 # Replace with function body.


func _on_slime4_killed():
	open = open+1

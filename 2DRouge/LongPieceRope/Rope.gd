extends KinematicBody2D

var PIECE = preload("res://LongPieceRope/Piece.tscn")
var velocity = Vector2()
var speed = 750
var collision
var fine = true
var move = true
var lastpiecepath
signal lastpiece
signal grap
export (int) var pieces = 1

func _ready():
#	print('pieces',pieces)
	var parent = $Anchor
	for i in range (pieces):
#		print('i',i)
		
		parent = addPiece(parent)
		
		if i == pieces-1:
			lastpiecepath = parent.get_path()
			print('lastpiecelastpiece')
			emit_signal("lastpiece")
			
		
		
func addPiece(parent):
	var joint = parent.get_node("CollisionShape2D/Joint")
	var piece = PIECE.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece

func lastpieceget_path():

	return lastpiecepath
	

	
func shoot(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	
	if move== true :
		collision = move_and_collide(velocity * delta)



#func _on_Area2D_body_entered(body):
#	if body.is_in_group("bordo") :
#		move = false
#		$AnimatedSprite.play("default")
#		print('lastpiecelastpiece')
#		emit_signal("lastpiece")
		


#func _on_pp11_grapend():
#	print('_on_pp11_grapend_on_pp11_grapend_on_pp11_grapend_on_pp11_grapend')
#	queue_free()





func _on_Area2D_body_entered(body):
	if body.is_in_group("bordo") :
		move = false
		$AnimatedSprite.play("default")
	
		emit_signal("grap")
		

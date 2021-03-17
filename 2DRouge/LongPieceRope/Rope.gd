extends KinematicBody2D

var PIECE = preload("res://LongPieceRope/Piece.tscn")
var velocity = Vector2()
var speed = 750
var collision
export (int) var pieces = 1

func _ready():
	var parent = $Anchor
	for i in range (pieces):
		parent = addPiece(parent)

func addPiece(parent):
	var joint = parent.get_node("CollisionShape2D/Joint")
	var piece = PIECE.instance()
	joint.add_child(piece)
	joint.node_a = parent.get_path()
	joint.node_b = piece.get_path()
	return piece
	
func shoot(pos, dir):
	rotation = dir
	position = pos
	velocity = Vector2(speed, 0).rotated(rotation)

func _physics_process(delta):
	
	collision = move_and_collide(velocity * delta)



func _on_Area2D_body_entered(body):
	if body.is_in_group("bordo") :
		$AnimatedSprite.play("default")

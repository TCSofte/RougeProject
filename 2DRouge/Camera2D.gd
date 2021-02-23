extends Camera2D

onready var window_size = Vector2(320,240)#OS.get_window_size()
onready var player = get_parent().get_node("KinematicBody2D")
onready var player_world_pos = get_player_world_pos()
onready var new_player_grid_pos = Vector2()
onready var tweenStart = false
onready var tween = get_node("Tween")
onready var new_cam_pos = Vector2()

func _ready():	
	#OS.set_window_size(window_size)
	var canvas_transform = get_viewport().get_canvas_transform()
	print(canvas_transform)
	self.set_offset(Vector2(window_size.x/2,window_size.y/2))
	#canvas_transform[2] = player_world_pos * window_size
	#get_viewport().set_canvas_transform(canvas_transform)
	#tween.connect('tween_completed', self, 'tweenCompleted')
	set_process(true)
	update_camera()

func tweenCompleted():
	tweenStart = false

func _process(delta):
	
	"""if tweenStart:
		print('start')
		
	pass"""

func get_player_world_pos():
	var pos = player.get_position()
	var x = floor(pos.x / window_size.x)	
	var y = floor(pos.y / window_size.y)
	return Vector2(x, y)
	
func update_camera():
	#print(get_player_world_pos())
	new_player_grid_pos = (player.get_position()/window_size).floor()
	#self.position += Vector2(1,0)
	var transform

	#print((player.get_position()/(window_size)).normalized())
	#print(get_player_world_pos())

	if new_player_grid_pos != player_world_pos:
		#print('::::' + str(new_player_grid_pos))
		player_world_pos = new_player_grid_pos		
		#print('::::' + str(new_player_grid_pos * (window_size)))
		tweenStart = true
		new_cam_pos = new_player_grid_pos * (window_size)
		tween.interpolate_property(self, "position", self.get_position(), new_cam_pos, 1.0, Tween.TRANS_EXPO, Tween.EASE_IN_OUT)	
		tween.start()
		print('move camera')
		#self.position = new_player_grid_pos * (window_size)
		#print(self.position)
		"""transform = get_viewport().get_canvas_transform()
		transform[2] = -player_world_pos * window_size
		get_viewport().set_canvas_transform(transform)"""
	return transform

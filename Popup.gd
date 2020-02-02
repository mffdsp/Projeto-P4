extends Popup

var base = Vector2(OS.window_size.x /2 - 10, OS.window_size.y/2 - 100)

func _ready():
	set_position(base)
	pass


func _process(delta):
	
	if Input.is_action_just_pressed("pause"):
		print('aaa')
		if(get_tree().paused == true):
			get_tree().paused = false;
			self.hide()
		else:
			get_tree().paused = true;
			self.show()
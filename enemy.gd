extends Area2D

var base = Vector2(60, 0)
var x_max = OS.window_size.x - 32;
var x_min = 32;
onready var person = get_parent().get_node("person")
var v =  Vector2(-500, 0)

func _ready():
	set_position(base)
	print('assa')
	connect("area_entered", person, "colidiu")
	pass

func _physics_process(delta):
	self.set_position(self.position + v * delta)
	
	if(self.position.x <= x_min - 922):
		var newV = v.x - 100
		v = Vector2(newV, 0)
		self.set_position(base)
		
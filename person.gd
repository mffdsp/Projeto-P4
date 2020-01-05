extends Area2D

onready var enemy = get_parent().get_node("enemy")

var base = Vector2(90, 550)
var g = 3000
var v = Vector2()
var v_jump = -1000
var x_max = OS.window_size.x - 32;
var x_min = 32;

func _ready():
	set_position(base)
	pass

func _physics_process(delta):
	
	if Input.is_action_pressed("ui_up"):
		v.y += g * delta
	else:
		v.y += g * 2 * delta
		
	if Input.is_action_just_pressed("ui_up") and self.position == base:
		v.y = v_jump
	
	if Input.is_action_pressed("ui_left") and self.position.x >= x_min:
		self.position.x -= 10
		
		
	if Input.is_action_pressed("ui_right") and self.position.x <= x_max:
		self.position.x += 10
		
		
	self.position += v * delta
	
	
	if get_position().y > base.y:
		base = Vector2(self.position.x, base.y)
		set_position(base)
		v = Vector2()

func colidiu(area):
	print("morreu")
		

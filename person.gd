extends Area2D

onready var pont = get_parent().get_node("pont2")
var EnemyScn = preload("res://enemy.tscn")

var base = Vector2(OS.window_size.x /2, 550)
var g = 3000
var v = Vector2()
var v_jump = -1000
var x_max = OS.window_size.x - 32;
var x_min = 48
var tempo = 1
var spawn = 3
var pontos = 0
var best = 0
var prot_cd = 3
var is_idle = 0
var prot_dur = 0
var jump_time = 0
var onTheFloor
func _ready():
	self.hideALL()
	get_node("normal").show()
	$AnimationPlayer.play("playerAnimation")
	get_parent().get_node("weed").hide()
	$AnimationPlayer.play("playerAnimation")
	self.set_position(base)
	pass

func _physics_process(delta):
	
	prot_cd += delta
	prot_dur -= delta
	jump_time -= delta
	
	onTheFloor = self.position.y >= 500
	
	if is_idle == 1 or onTheFloor:
		hideALL()
		get_node("normal").show()
		$AnimationPlayer.play("playerAnimation")
		is_idle = 0
		
	if !onTheFloor:
		hideALL()
		get_node("Jump").show()
		$AnimationPlayer.play("jump")
		
	self.connect("area_entered", get_parent().get_node("enemy"), "colidiu")
	
	get_parent().get_node("weed").set_position(self.position)
	
	if Input.is_action_pressed("ui_up"):
		v.y += g * delta
	else:
		v.y += g * 2 * delta
		
	if Input.is_action_just_pressed("ui_up") and self.position == base:
		$jumpSound.play()
		is_idle = 1
		v.y = v_jump
	
	if Input.is_action_pressed("ui_left") and self.position.x >= x_min:
		if(onTheFloor):
			self.hideALL()
			get_node("Run2").show()
			$run2.play("jump")
		self.position.x -= 8
		
		
	if Input.is_action_pressed("ui_right") and self.position.x <= x_max:
		if(onTheFloor):
			hideALL()
			get_node("Run").show()
			$run.play("run")
		self.position.x += 8
	
	if Input.is_action_just_released("ui_right"):
		is_idle = 1
		self.hideALL()
		get_node("normal").show()
	
	if Input.is_action_just_released("ui_left"):
		is_idle = 1
		self.hideALL()
		get_node("normal").show()
		
		
	#abaixar
		if Input.is_action_pressed("ui_down"):
			print("abaixou")
		$AnimationPlayer.play("playerDown")
		(self.get_node("CollisionShape2D").position.y) = 30
	if Input.is_action_just_released("ui_down"):
		print("elevantou")
		$AnimationPlayer.play("playerAnimation")
		(self.get_node("CollisionShape2D").position.y) = -5
		
	self.position += v * delta
	
	#prote
	var shieldPressed = Input.is_action_just_pressed("prot")
	if	shieldPressed && prot_cd >= 3:
		prot_cd = -10
		
		get_parent().immortal = 1
		get_parent().get_node("weed").show()
		$shieldSound.play()
		
		prot_dur = 5 
	elif shieldPressed && prot_cd < 3:
		print("Em cd")
	
	if(prot_dur <= 0):
		get_parent().immortal = 0
		get_parent().get_node("weed").hide()
		
	if get_position().y > base.y:
		base = Vector2(self.position.x, base.y)
		set_position(base)

func hideALL():
	get_node("normal").hide()
	get_node("Run2").hide()
	get_node("Run").hide()
	get_node("Jump").hide()
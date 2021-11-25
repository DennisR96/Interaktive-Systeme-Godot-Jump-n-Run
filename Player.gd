class_name Player

extends KinematicBody2D

export var GRAVITY = 8.1 
export var SPEED = 50						# Geschwindigkei
export var jump_force = -240	
export var double_jump = false	
var collectables = 0
var playerHit = false

signal player_hit

var can_fire = true
var PROJECTILE = preload("res://Projectile.tscn")

var velocity = Vector2(0,0)

func _physics_process(delta):
	# Walking 
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
		if sign($Position2D.position.x) == -1:
			$Position2D.position.x *= -1
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
		if sign($Position2D.position.x) == 1:
			$Position2D.position.x *= -1
	elif not playerHit: # not playerHit wichtig, damit ein kurzer seitlicher Sprung des Players stattfinden kann, wenn er von einem Enemy getroffen wird
		velocity.x = 0
	
	# Jumping
	if is_on_floor():
		double_jump = false
		
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_force
		elif !double_jump:
			velocity.y = jump_force
			double_jump = true
	if Input.is_action_just_pressed("ui_focus_next") and can_fire:
		var projectile_instance = PROJECTILE.instance()
		if not $AnimatedSprite.flip_h:
			projectile_instance.direction = 1
		elif $AnimatedSprite.flip_h:
			projectile_instance.direction = -1
		projectile_instance.global_position = $Position2D.global_position
		get_parent().add_child(projectile_instance)
		can_fire = false
		yield(get_tree().create_timer(1),'timeout')
		can_fire = true
		
	# Play Animation
	if playerHit:
		$AnimatedSprite.play("Hit")
#	elif is_on_wall():
#		$AnimatedSprite.play("WallJump")
	elif double_jump:
		$AnimatedSprite.play("DoubleJump")
	elif velocity.y < 0:
		$AnimatedSprite.play("Jump")
	elif velocity.y > 0:
		$AnimatedSprite.play("Fall")
	elif velocity.x != 0 and velocity.y == 0:
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
	
	# Player an der Wand
#	if is_on_wall() and not is_on_floor():
#		velocity.y = 10
#		if $AnimatedSprite.flip_h:
#			velocity.x = -5
#		else:
#			velocity.x = 5
#	else:
#		velocity.y += GRAVITY
	
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)
	
# Enemy-Skript greift auf diese Funktion zu
func bounce():
	velocity.y = jump_force * 0.7
	
# Enemy-Skript greift auf diese Funktion zu
func ouch(var enemyPosX):
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	playerHit = true
	emit_signal("player_hit")
	#set_modulate(Color(1,0.3,0.3,0.3)) #Farbe ändern 
	velocity.y = jump_force * 0.5 # Kleiner Sprung
	
	if position.x < enemyPosX:
		velocity.x = -400
	elif position.x > enemyPosX:
		velocity.x = 400
	
	$Timer.start()
	
func ouchFallzone():
	emit_signal("player_hit")
	#set_modulate(Color(1,0.3,0.3,0.3)) #Farbe ändern 
	velocity.y = jump_force * 0.7 # Kleiner Sprung
	if position.x <= 200:
		position.x = 128
		position.y = 224
	elif position.x > 200 and position.x <= 550:
		position.x = 376
		position.y = 240
	elif position.x > 550:
		position.x = 880
		position.y = 240
	
	playerHit = true
	$Timer.start()

func _on_Timer_timeout():
	playerHit = false

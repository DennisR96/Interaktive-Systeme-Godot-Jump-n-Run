class_name Player

extends KinematicBody2D

export var GRAVITY = 8.1 
export var SPEED = 50						# Geschwindigkei
export var jump_force = -240			
var collectables = 0
var playerHit = false

signal player_hit

const PROJECTILE = preload("res://Projectile.tscn")

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
#	else:
#		velocity.x = 0
		
	# Jumping 
	if Input.is_action_just_pressed("ui_up") or Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = jump_force
		
	# Projectile
	if Input.is_action_just_pressed("ui_focus_next"):
		var projectile = PROJECTILE.instance()
		get_parent().add_child(projectile)
		projectile.position = $Position2D.global_position 
		
	# Play Animation
	if playerHit:
		$AnimatedSprite.play("Hit")
	elif velocity.y < 0 and not playerHit:
		$AnimatedSprite.play("Jump")
	elif velocity.y > 0 and not playerHit:
		$AnimatedSprite.play("Fall")
	elif velocity.x != 0 and velocity.y == 0 and not playerHit:
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)
	
# Enemy-Skript greift auf diese Funktion zu
func bounce():
	velocity.y = jump_force * 0.7
	
# Enemy-Skript greift auf diese Funktion zu
func ouch(var enemyPosX):
	emit_signal("player_hit")
	#set_modulate(Color(1,0.3,0.3,0.3)) #Farbe ändern 
	velocity.y = jump_force * 0.5 # Kleiner Sprung
	
	if position.x < enemyPosX:
		velocity.x = -400
	elif position.x > enemyPosX:
		velocity.x = 400
	
	Input.action_release("left")
	Input.action_release("right")
	
	playerHit = true
	$Timer.start()
	
func ouchFallzone():
	emit_signal("player_hit")
	#set_modulate(Color(1,0.3,0.3,0.3)) #Farbe ändern 
	velocity.y = jump_force * 0.7 # Kleiner Sprung
	
	position.x = 128
	position.y = 192
	
	playerHit = true
	$Timer.start()

func _on_Timer_timeout():
	playerHit = false

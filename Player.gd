class_name Player

extends KinematicBody2D

export var GRAVITY = 8.1 
export var SPEED = 50						# Geschwindigkei
export var jump_force = -240			
var collectables = 0

const PROJECTILE = preload("res://Projectile.tscn")

var velocity = Vector2()

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
	else:
		velocity.x = 0
		
	# Jumping 
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
		
	# Projectile
	if Input.is_action_just_pressed("ui_focus_next"):
		var projectile = PROJECTILE.instance()
		get_parent().add_child(projectile)
		projectile.position = $Position2D.global_position 
		
	# Play Animation
	if velocity.y < 0:
		$AnimatedSprite.play("Jump")
	elif velocity.y > 0:
		$AnimatedSprite.play("Fall")
	elif velocity.x != 0 and velocity.y == 0:
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	

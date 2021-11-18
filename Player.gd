class_name Player

extends KinematicBody2D

export var GRAVITY = 8.1 
export var SPEED = 50						# Geschwindigkei
export var jump_force = -240			

var velocity = Vector2()

var Projectile = preload("res://Projectile.tscn") 

func shoot():								# Marker 1
	var p = Projectile.instance()
	#owner.add_child(p)
	p.transform = $Muzzle.transform	


func _physics_process(delta):
	# Walking Animation
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.play("Walk")
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.play ("Walk")
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
		$AnimatedSprite.play("Idle")
		
	# Jumping Animation
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
	
	if Input.is_action_just_pressed("ui_focus_next"):
		shoot()
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)


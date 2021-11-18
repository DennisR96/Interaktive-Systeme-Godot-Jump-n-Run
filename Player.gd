class_name Player

extends KinematicBody2D

export var GRAVITY = 8.1 
export var SPEED = 50						# Geschwindigkei
export var jump_force = -240			
var collectables = 0

var velocity = Vector2()

var Projectile = preload("res://Projectile.tscn") 

func shoot():								# Marker 1
	var p = Projectile.instance()
	#owner.add_child(p)
	p.transform = $Muzzle.transform	


func _physics_process(delta):
	# Walking 
	if Input.is_action_pressed("ui_right"):
		velocity.x = SPEED
		$AnimatedSprite.flip_h = false
	elif Input.is_action_pressed("ui_left"):
		velocity.x = -SPEED
		$AnimatedSprite.flip_h = true
	else:
		velocity.x = 0
		
	# Jumping 
	if Input.is_action_just_pressed("ui_up") and is_on_floor():
		velocity.y = jump_force
		
	# Play Animation
	if velocity.y < 0:
		$AnimatedSprite.play("Jump")
	elif velocity.y > 0:
		$AnimatedSprite.play("Fall")
	elif velocity.x != 0 and velocity.y == 0:
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
		
	
	if Input.is_action_just_pressed("ui_focus_next"):
		shoot()
		
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, Vector2.UP)
	
	# Wenn alle Items eingesammelt
	if collectables == 2:
		#get_tree().change_scene("res://01_LevelA.tscn")
		print("Winner!")

func add_collectable():
	collectables = collectables + 1
	print("Number Collectables: ", collectables)

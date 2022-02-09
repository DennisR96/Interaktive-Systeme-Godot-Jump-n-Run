class_name Player

extends KinematicBody2D

export var GRAVITY = 8.1 
export var SPEED = 70						# Geschwindigkei
export var jump_force = -240	
export var double_jump = false	
export var wallJump = 300
var collectables = 0
var playerHit = false

signal player_hit
signal shooting

var can_fire = false
var PROJECTILE = preload("res://Scripts/Projectile.tscn")

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
	if is_on_floor() or nextToWall():
		double_jump = false
		
	if Input.is_action_just_pressed("ui_up"):
		if is_on_floor():
			velocity.y = jump_force
			$PlayerJump.play()
		elif not is_on_floor() and nextToLeftWall():
			$AnimatedSprite.flip_h = true
			velocity.x += wallJump
			velocity.y = jump_force
			$PlayerJump.play()
		elif not is_on_floor() and nextToRightWall():
			$AnimatedSprite.flip_h = false
			velocity.x -= wallJump
			velocity.y = jump_force
			$PlayerJump.play()
		elif not is_on_floor() and not nextToWall() and !double_jump:
			$PlayerJump.play()
			velocity.y = jump_force
			double_jump = true

	# Langsames fallen, wenn an Wand
	if nextToWall() and velocity.y > 30:
		velocity.y = 30
		
	if Input.is_action_just_pressed("ui_down"):
		for i in get_slide_count():
			var collision = get_slide_collision(i)
			if collision.collider.get_parent().name == "TilesOneWay":
				for j in collision.collider.get_child_count():
					collision.collider.get_child(j).disabled = true
				yield(get_tree().create_timer(0.5),'timeout')
				for k in collision.collider.get_child_count():
					collision.collider.get_child(k).disabled = false
				
		
	if Input.is_action_just_pressed("ui_focus_next") and can_fire:
		var projectile_instance = PROJECTILE.instance()
		if not $AnimatedSprite.flip_h:
			projectile_instance.direction = 1
		elif $AnimatedSprite.flip_h:
			projectile_instance.direction = -1
		projectile_instance.global_position = $Position2D.global_position
		get_parent().add_child(projectile_instance)
		collectables -= 5
		if collectables < 5:
			can_fire = false
		$PlayerShoot.play()
		emit_signal("shooting")
		yield(get_tree().create_timer(1),'timeout')
		
	# Play Animation
	if playerHit:
		$AnimatedSprite.play("Hit")
	elif nextToWall() and not is_on_floor():
		$AnimatedSprite.play("WallJump")
	elif double_jump:
		$AnimatedSprite.play("DoubleJump")
	elif velocity.y < 0 and not is_on_floor():
		$AnimatedSprite.play("Jump")
	elif velocity.y > 0 and not is_on_floor():
		$AnimatedSprite.play("Fall")
	elif velocity.x != 0 and velocity.y == 0:
		$AnimatedSprite.play("Walk")
	else:
		$AnimatedSprite.play("Idle")
	
	
	velocity.y += GRAVITY
	if is_on_floor():
		velocity = move_and_slide_with_snap(velocity, Vector2(0, 1), Vector2.UP)
	else:
		velocity = move_and_slide(velocity, Vector2.UP)
	velocity.x = lerp(velocity.x, 0, 0.2)

func nextToWall():
	# Kein Wall Jump bei den One Way Plattformen
	if nextToLeftWall():
		if $LeftWall.get_collider().get_parent().get_name() == "TilesOneWay":
			return false
	if nextToRightWall():
		if $RightWall.get_collider().get_parent().get_name() == "TilesOneWay":
			return false
	# Wenn normale Plattform
	return nextToRightWall() or nextToLeftWall()

func nextToRightWall():
	return $RightWall.is_colliding()
	
func nextToLeftWall():
	return $LeftWall.is_colliding()

# Enemy-Skript greift auf diese Funktion zu
func bounce():
	$PlayerCrush.play()
	velocity.y = jump_force * 0.7
	
# Enemy-Skript greift auf diese Funktion zu
func ouch(var enemyPosX):
	$PlayerDead.play()
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_down")
	Input.action_release("ui_up")
	playerHit = true
	emit_signal("player_hit")
	#set_modulate(Color(1,0.3,0.3,0.3)) #Farbe ändern 
	velocity.y = jump_force * 0.5 # Kleiner Sprung
	
	if position.x < enemyPosX:
		velocity.x = -400
	elif position.x > enemyPosX:
		velocity.x = 400
	$Timer.start()
	
func ouchWallSpikes():
	$PlayerDead.play()
	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_down")
	Input.action_release("ui_up")
	playerHit = true
	emit_signal("player_hit")
	
	velocity.y = jump_force * 0.5 # Kleiner Sprung
	if $AnimatedSprite.flip_h == false:
		velocity.x = -400
	elif $AnimatedSprite.flip_h == true:
		velocity.x = 400
	
	$Timer.start()
	
func ouchFallzone():
	$PlayerDead.play()
	emit_signal("player_hit")
	#set_modulate(Color(1,0.3,0.3,0.3)) #Farbe ändern 
	velocity.y = jump_force * 0.7 # Kleiner Sprung

	Input.action_release("ui_left")
	Input.action_release("ui_right")
	Input.action_release("ui_down")
	Input.action_release("ui_up")
	
	if (get_tree().get_current_scene().get_name() == "Level1"):
		position.x = 116
		position.y = 256
	elif (get_tree().get_current_scene().get_name() == "Level2"):
		if position.x < 1700:
			position.x = 432
			position.y = 240
		elif position.x >= 1700 and position.x < 2200:
			position.x = 1860
			position.y = 272
		elif position.x >= 2200:
			position.x = 2392
			position.y = 220
	elif (get_tree().get_current_scene().get_name() == "Level3"):
		if position.x < 800:
			position.x = 51
			position.y = 240
		elif position.x >= 800 and position.x < 1248:
			position.x = 808
			position.y = 190
		elif position.x >= 1248:
			position.x = 1248
			position.y = 240
			
	
	playerHit = true
	$Timer.start()
	
func ouchProjectile():
	$PlayerDead.play()
	emit_signal("player_hit")
	playerHit = true
	velocity.y = jump_force * 0.7 
	$Timer.start()

func _on_Timer_timeout():
	playerHit = false

func _on_collectable_collected():
	collectables += 1
	print(collectables)
	if collectables >= 5:
		can_fire = true
	




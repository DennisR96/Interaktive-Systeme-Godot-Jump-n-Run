extends KinematicBody2D

var SPEED = 75
var SPEED_WALK = 500
var velocity = Vector2()
var player = null
export var direction = -1
var timeout
var dead = false
var stage = 0
var PROJECTILE = preload("res://Scripts/Projectile_Enemy.tscn") 
export var detects_cliffs = true
var projec

func _ready():
	var stage = 0
	$AnimatedSprite.play("Idle")
	$Timer2.start()
	if direction == 1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D2.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	
# Movements	
func flying():
		#velocity = Vector2.ZERO
		if player:
			velocity = position.direction_to(player.position) * SPEED
		velocity = move_and_slide(velocity)
		
func shoot():
	$Timer2.start()
	var projectile_instance = PROJECTILE.instance()
	projectile_instance.global_position = $Position2D.global_position
	projec = randi() % 2
	if projec == 0:
		projectile_instance.direction = 1
	else:
		projectile_instance.direction = -1
	get_parent().add_child(projectile_instance)
	
func walk():
	var velocity = Vector2()
	if is_on_wall() or not $floor_checker.is_colliding() and detects_cliffs and is_on_floor():
		direction = direction * -1
		$AnimatedSprite.flip_h = not $AnimatedSprite.flip_h
		$floor_checker.position.x = $CollisionShape2D2.shape.get_extents().x * direction
	velocity.y += 200
	velocity.x = SPEED_WALK * direction
	velocity = move_and_slide(velocity, Vector2.UP)
	

func _physics_process(delta):
	# Stage 0 - Flying 
	if stage == 0:
		flying()
	
	# Stage 1 - Flying and Shooting
	if stage == 1:
		flying()
		if $Timer2.is_stopped():
			shoot()
	
	# Stage 2 - Walking fast
	if stage == 2:
		walk()
	
	# Animation der Richtung anpassen
	if velocity.x < 0:
		$AnimatedSprite.flip_h = true
	else:
		$AnimatedSprite.flip_h = false

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		player = body

func _on_top_checker_body_entered(body):
	if body.name == "Player":
		
		$AnimatedSprite.play("Damage")
		dead()
		velocity = move_and_slide(Vector2.ZERO)
		SPEED = 0
		body.bounce()	
		yield(get_tree().create_timer(1),'timeout')
		if stage == 1:
			SPEED = 50
			$AnimatedSprite.play("Charge")
		if stage == 2:
			$AnimatedSprite.play("Run")
		if stage >= 3:
			dead()
		
func _on_sides_checker_body_entered(body):
	if body.name == "Player":
		body.ouch(position.x)
	
# Für zum Beispiel das Projketil
func dead():

	SPEED = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_layer_bit(4, false)
	$sides_checker.set_collision_mask_bit(0, false)
	yield(get_tree().create_timer(1),'timeout')
	stage += 1	
	if stage < 3:
		set_collision_layer_bit(4, true)
		set_collision_mask_bit(0, true)
		$top_checker.set_collision_layer_bit(4, true)
		$top_checker.set_collision_mask_bit(0, true)
		$sides_checker.set_collision_layer_bit(4, true)
		$sides_checker.set_collision_mask_bit(0, true)
	if stage >= 3:
		queue_free()
	




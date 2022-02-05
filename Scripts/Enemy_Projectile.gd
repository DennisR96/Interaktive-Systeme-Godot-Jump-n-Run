extends KinematicBody2D

var speed = 30
var velocity = Vector2()
var dead = false
export var direction = 1
export var detects_cliffs = true
signal collectable_collected
var PROJECTILE = preload("res://Scripts/Projectile_Enemy.tscn") 

func _ready():
	$AnimatedSprite.play("Idle")
	if direction == -1:
		$AnimatedSprite.flip_h = true
	$floor_checker.position.x = $CollisionShape2D2.shape.get_extents().x * direction
	$floor_checker.enabled = detects_cliffs
	
func shoot():
	$Timer2.start()
	$AnimatedSprite.play("Shoot")
	yield(get_tree().create_timer(2.0),"timeout") # Damit Animation mit Schießen übereinstimmt
	var projectile_instance = PROJECTILE.instance()
	projectile_instance.global_position = $Position2D.global_position
	if direction == -1:
		projectile_instance.direction = 1
	else:
		projectile_instance.direction = -1
	get_parent().add_child(projectile_instance)
	yield($AnimatedSprite, "animation_finished")
	$AnimatedSprite.play("Idle")
	
func _process(delta):
	if $Timer2.is_stopped():
		shoot()

func _physics_process(delta):
	pass

func dead():
	$AnimatedSprite.play("Hit")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_layer_bit(4, false)
	$sides_checker.set_collision_mask_bit(0, false)
	$Timer.start()		# Timer, dannach wird Enemy gelöscht

# Wenn Player auf Enemy draufspringt
func _on_top_checker_body_entered(body):
	dead = true
	$AnimatedSprite.play("Hit")
	speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_layer_bit(4, false)
	$sides_checker.set_collision_mask_bit(0, false)
	$Timer.start()		# Timer, dannach wird Enemy gelöscht
	body.bounce()		# Player macht kleinen Sprung
	

# Wenn Player seitlich in Enemy reinläuft
func _on_sides_checker_body_entered(body):
	body.ouch(position.x)

# Enemy löschen nach timeout
func _on_Timer_timeout():
	queue_free()
	pass



func _on_Timer2_timeout():
	if not dead:
		shoot()
	pass # Replace with function body.

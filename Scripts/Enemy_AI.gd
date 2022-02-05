extends KinematicBody2D

var speed = 50
var velocity = Vector2.ZERO
var player = null
var dead = false
var entered = 0

func _ready():
	$AnimatedSprite.play("flying")

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * speed
	velocity = move_and_slide(velocity)
	# Animation der Richtung anpassen
	if velocity.x < 0 and entered == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true	

func _on_Area2D_body_entered(body):
	entered = 1
	if body.name == "Player":
		player = body

func _on_top_checker_body_entered(body):
	if body.name == "Player":
		body.bounce()
		dead()
		
func _on_sides_checker_body_entered(body):
	if body.name == "Player":
		body.ouch(position.x)
	pass # Replace with function body.
	
func dead():
	# Player kann nicht noch mal den Body des Enemys betreten
	velocity = move_and_slide(Vector2.ZERO)
	speed = 0
	$AnimatedSprite.play("hit")
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_layer_bit(4, false)
	$sides_checker.set_collision_mask_bit(0, false)
	
	yield(get_tree().create_timer(1),'timeout')
	queue_free()

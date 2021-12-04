extends KinematicBody2D

var run_speed = 50
var velocity = Vector2.ZERO
var player = null
var dead = false

func _ready():
	$AnimatedSprite.play("flying")

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	velocity = move_and_slide(velocity)
	# Animation der Richtung anpassen
	if velocity.x < 0:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h = true
		
	pass

func _on_Area2D_body_entered(body):
	if body.name == "Player":
		print("A0")
		player = body


func _on_Area2D_body_exited(body):
	player = null
	pass
	#player = null 

func _on_top_checker_body_entered(body):
	if body.name == "Player":
		velocity = move_and_slide(Vector2.ZERO)
		run_speed = 0
		$AnimatedSprite.play("hit")
		body.bounce()
		
		# Player kann nicht noch mal den Body des Enemys betreten
		set_collision_layer_bit(4, false)
		set_collision_mask_bit(0, false)
		$top_checker.set_collision_layer_bit(4, false)
		$top_checker.set_collision_mask_bit(0, false)
		$sides_checker.set_collision_layer_bit(4, false)
		$sides_checker.set_collision_mask_bit(0, false)
		
		yield(get_tree().create_timer(1),'timeout')
		queue_free()
		
func _on_sides_checker_body_entered(body):
	if body.name == "Player":
		body.ouch(position.x)
	pass # Replace with function body.
	
# Für zum Beispiel das Projketil
func dead():
	$AnimatedSprite.play("hit")
	run_speed = 0
	set_collision_layer_bit(4, false)
	set_collision_mask_bit(0, false)
	$top_checker.set_collision_layer_bit(4, false)
	$top_checker.set_collision_mask_bit(0, false)
	$sides_checker.set_collision_layer_bit(4, false)
	$sides_checker.set_collision_mask_bit(0, false)
	yield(get_tree().create_timer(1),'timeout')
	queue_free()

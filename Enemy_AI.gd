extends KinematicBody2D

var run_speed = 25
var velocity = Vector2.ZERO
var player = null
var dead = false

func _ready():
	$AnimatedSprite.play("default")

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	velocity = move_and_slide(velocity)
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
		$AnimatedSprite.play("hit")
		body.bounce()
		yield(get_tree().create_timer(1),'timeout')
		queue_free()
		
func _on_sides_checker_body_entered(body):
	if body.name == "Player":
		body.ouch(position.x)
	pass # Replace with function body.

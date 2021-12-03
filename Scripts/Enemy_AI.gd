extends KinematicBody2D

var run_speed = 25
var velocity = Vector2.ZERO
var player = null

func _physics_process(delta):
	velocity = Vector2.ZERO
	if player:
		velocity = position.direction_to(player.position) * run_speed
	velocity = move_and_slide(velocity, Vector2.UP)

func _on_DetectRadius_body_entered(body):
	print("test")
	player = body

func _on_DetectRadius_body_exited(body):
	player = null

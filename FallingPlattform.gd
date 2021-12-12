extends Node2D

var t = Timer.new()

func _ready():
	pass # Replace with function body.

func _on_Area2D_body_entered(body):
	
	if body.get_name() == "Player":
		$AnimationPlayer.play("Falling")
		yield(get_tree().create_timer(0.5), "timeout")
		$KinematicBody2D.visible = false
		$KinematicBody2D/CollisionShape2D.disabled = true
		yield(get_tree().create_timer(2), "timeout")
		$KinematicBody2D.visible = true
		$KinematicBody2D/CollisionShape2D.disabled = false
	pass # Replace with function body.

extends Area2D

func _on_Collectable_body_entered(body):
	$AnimatedSprite.play("Collected")
	body.add_collectable()
	yield($AnimatedSprite, "animation_finished")
	queue_free()

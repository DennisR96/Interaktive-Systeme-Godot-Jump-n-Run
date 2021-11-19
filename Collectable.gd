extends Area2D

signal collectable_collected

func _on_Collectable_body_entered(body):
	$AnimatedSprite.play("Collected")
	emit_signal("collectable_collected")
	set_collision_mask_bit(0, false) # Damit man das Objekt nicht 2x einsammeln kann
	yield($AnimatedSprite, "animation_finished")
	queue_free() # Objekt löschen

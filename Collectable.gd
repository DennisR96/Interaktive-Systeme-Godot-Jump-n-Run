extends Area2D

signal collectable_collected

func _on_Collectable_body_entered(body):
	$AnimatedSprite.play("Collected")
	emit_signal("collectable_collected")
	set_collision_mask_bit(0, false) # Damit man das Objekt nicht 2x einsammeln kann
	if body.get_name() == "Player":
		body.get_node("PlayerCoin").play()
		print("Coin collected audio")
	yield($AnimatedSprite, "animation_finished")
	queue_free() # Objekt löschen

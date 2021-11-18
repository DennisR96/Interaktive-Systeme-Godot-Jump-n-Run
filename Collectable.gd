extends Area2D

func _on_Collectable_body_entered(body):
	queue_free()

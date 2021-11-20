extends Node

func _on_Area2D_body_entered(body):
	get_tree().reload_current_scene()
	pass # Replace with function body.

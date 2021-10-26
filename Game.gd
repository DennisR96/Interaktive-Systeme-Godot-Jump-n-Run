extends Node

func _on_Area2D_body_entered(body):
	get_tree().reload_current_scene()
	pass # Replace with function body.


func _on_Button_pressed():
	get_tree().change_scene("res://Node2D.tscn")
	pass # Replace with function body.

extends Node

func _on_Area2D_body_entered(body):
	if (body.get_name() == "Player"):
		body.ouchFallzone()
		
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://00_Menu.tscn")

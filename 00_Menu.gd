extends Control

func _ready():
	pass 

func _on_Start_pressed():
	get_tree().change_scene("res://01_LevelA.tscn")			# Starts Level A
	pass 

func _on_Exit_pressed():
	get_tree().quit()										# Quits Game
	if OS.has_feature('JavaScript'):
		JavaScript.eval("window.close()")
	pass


func _on_Controls_pressed():
	get_tree().change_scene("res://ControlsMenu.tscn")
	pass # Replace with function body.

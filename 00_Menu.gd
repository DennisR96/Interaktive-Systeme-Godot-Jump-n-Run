extends Control

func _ready():
	$Control.visible = false
	$Settings.visible = false
	pass 

func _on_Start_pressed():
	get_tree().change_scene("res://01_Level1.tscn")			# Starts Level A
	pass 

func _on_Exit_pressed():
	get_tree().quit()										# Quits Game
	if OS.has_feature('JavaScript'):
		JavaScript.eval("window.close()")
	pass


func _on_Controls_pressed():
	#get_tree().change_scene("res://ControlsMenu.tscn")
	$Control.visible = true
	pass # Replace with function body.

func _on_Settings_pressed():
	#get_tree().change_scene("res://SettingsMenu.tscn")
	$Settings.visible = true
	pass # Replace with function body.


func _on_Option_pressed():
	$Control.visible = false
	pass # Replace with function body.


func _on_Option2_pressed():
	$Settings.visible = false
	pass # Replace with function body.


func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)
	pass # Replace with function body.


func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)
	pass # Replace with function body.

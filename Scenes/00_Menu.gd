extends Control

func _ready():
	$Control.visible = false
	$Settings.visible = false

func _on_Start_pressed():
	get_tree().change_scene("res://Scenes/01_Level1.tscn")	

func _on_Exit_pressed():
	get_tree().quit()										
	if OS.has_feature('JavaScript'):
		JavaScript.eval("window.close()")

func _on_Controls_pressed():
	$Control.visible = true

func _on_Settings_pressed():
	$Settings.visible = true

func _on_Option_pressed():
	$Control.visible = false

func _on_Option2_pressed():
	$Settings.visible = false

func _on_HSlider_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), value)


func _on_HSlider2_value_changed(value):
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), value)

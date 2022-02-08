extends Node2D

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not is_instance_valid($Game/Enemies/Enemy_Final):
		$Game/Princess.visible = true
		$HUD/Message.text = "Super! Du hast die Prinzessin gerettet! Drücke ESC um zum Menü zurückzukehren."
		$HUD/Message.show()
		$HUD/DarkerDisplay.show()
		yield(get_tree().create_timer(5.0), "timeout")
		$HUD/Message.hide()
		$HUD/DarkerDisplay.hide()
	

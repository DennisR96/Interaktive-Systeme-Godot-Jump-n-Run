extends Node2D

var game_over = false

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not is_instance_valid($Game/Enemies/Enemy_Final):
		$Game/Princess.visible = true
		if not game_over:
			$HUD/Message.text = "Super! Du hast die Prinzessin gerettet! Drücke ESC um zum Menü zurückzukehren."
			$HUD/Message.show()
			$HUD/DarkerDisplay.show()
			game_over = true
			yield(get_tree().create_timer(5.0), "timeout")
			$HUD/Message.hide()
			$HUD/DarkerDisplay.hide()
	

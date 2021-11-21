extends CanvasLayer

var collectables = 0
var lifes = 3

func _ready():
	$Collectables.text = "0" + String(collectables)
	$Lifes.text = "0" + String(lifes)
	$Message.hide()

func _physics_process(delta):
	if collectables == 5:
		$Message.text = "Gewonnen! Alle Items wurden eingesammelt!"
		$Message.show()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://01_LevelA.tscn")
		
	if lifes == 0:
		$Message.text = "Game Over! Versuche es erneut"
		$Message.show()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://01_LevelA.tscn")

func _on_collectable_collected():
	collectables = collectables + 1
	if collectables < 10:
		$Collectables.text = "0" + String(collectables)
	else:
		$Collectables.text = String(collectables)
	
func _on_Player_player_hit():
	lifes = lifes - 1
	if lifes < 10 and lifes > 0:
		$Lifes.text = "0" + String(lifes)
	elif lifes <= 0:
		$Lifes.text = "00"
	else:
		$Lifes.text = String(lifes)
		

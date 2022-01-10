extends CanvasLayer

var collectablesInScene = 10
var currentCollectables = 0
var lifes = 5

func _ready():
	$Collectables.text = "00/" + String(collectablesInScene)
	$Lifes.text = "0" + String(lifes)
	$Message.hide()
	$Panel.show()
	$TextureRect.show()
	$x.show()
	$Collectables.show()
	$TextureRect2.show()
	$x2.show()
	$Lifes.show()

func _physics_process(delta):
	if currentCollectables == collectablesInScene:
		$Message.text = "Gewonnen! Alle Items wurden eingesammelt!"
		$Message.show()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://01_Level1.tscn")
		
	if lifes == 0:
		$Message.text = "Game Over! Versuche es erneut"
		$Message.show()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://01_Level1.tscn")

func _on_collectable_collected():
	currentCollectables = currentCollectables + 1
	if currentCollectables < 10:
		$Collectables.text = "0" + String(currentCollectables) + "/" + String(collectablesInScene)
	else:
		$Collectables.text = String(currentCollectables) + "/" + String(collectablesInScene)
	
func _on_Player_player_hit():
	lifes = lifes - 1
	if lifes < 10 and lifes > 0:
		$Lifes.text = "0" + String(lifes)
	elif lifes <= 0:
		$Lifes.text = "00"
	else:
		$Lifes.text = String(lifes)
		

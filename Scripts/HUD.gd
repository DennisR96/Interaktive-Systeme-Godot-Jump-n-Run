extends CanvasLayer

var max_available_projectiles = 3
var currentCollectables = 0
var available_projectile = 0
var lifes = 3

func _ready():
	$Collectables.text = "00/0" + String(max_available_projectiles)
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
	if lifes == 0:
		$Message.text = "Game Over! Versuche es erneut"
		$Message.show()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().reload_current_scene()

func _on_collectable_collected():
	currentCollectables = currentCollectables + 1
	#print(5 % currentCollectables)
	if currentCollectables % 5 == 0:
		available_projectile +=1
		$Collectables.text = "0" + String(available_projectile) + "/0" + String(max_available_projectiles)
	
func _on_Player_player_hit():
	lifes = lifes - 1
	if lifes < 10 and lifes > 0:
		$Lifes.text = "0" + String(lifes)
	elif lifes <= 0:
		$Lifes.text = "00"
	else:
		$Lifes.text = String(lifes)

func _on_NewLevel_body_entered(body):
	if body.get_name() == "Player":
		if (get_tree().get_current_scene().get_name() == "Level1"):
			get_tree().change_scene("res://Scenes/02_Level2.tscn")
		elif (get_tree().get_current_scene().get_name() == "Level2"):
			get_tree().change_scene("res://Scenes/03_Level3.tscn")


func _on_Player_shooting():
	currentCollectables -= 5 
	available_projectile -= 1
	$Collectables.text = "0" + String(available_projectile) + "/0" + String(max_available_projectiles)
	pass # Replace with function body.

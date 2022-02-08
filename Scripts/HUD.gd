extends CanvasLayer

var currentCollectables = 0
var collectablesInScene = 15
var available_projectile = 0
var lifes = 3

func _ready():
	$Panel/Collectables.text = "00/" + String(collectablesInScene)
	$Panel/Lifes.text = "0" + String(lifes)
	$Panel/Projectiles.text = "0" + String(available_projectile)
	$Message.hide()
	$DarkerDisplay.hide()
	$Panel.show()
	$Panel/TextureRect.show()
	$Panel/x.show()
	$Panel/Collectables.show()
	$Panel/TextureRect2.show()
	$Panel/x2.show()
	$Panel/Lifes.show()
	$Panel/TextureRect3.show()
	$Panel/x3.show()
	$Panel/Projectiles.show()

func _physics_process(delta):
	if lifes == 0:
		$Message.text = "Game Over! Versuche es erneut."
		$Message.show()
		$DarkerDisplay.show()
		yield(get_tree().create_timer(5.0), "timeout")
		get_tree().reload_current_scene()

func _on_collectable_collected():
	currentCollectables = currentCollectables + 1
	if currentCollectables < 10:
		$Panel/Collectables.text = "0" + String(currentCollectables) + "/" + String(collectablesInScene)
	else:
		$Panel/Collectables.text = String(currentCollectables) + "/" + String(collectablesInScene)
	
	if currentCollectables % 5 == 0:
		available_projectile +=1
		if available_projectile < 10:
			$Panel/Projectiles.text = "0" + String(available_projectile)
		else:
			$Panel/Projectiles.text = String(available_projectile)
	
func _on_Player_player_hit():
	lifes = lifes - 1
	if lifes < 10 and lifes > 0:
		$Panel/Lifes.text = "0" + String(lifes)
	elif lifes <= 0:
		$Panel/Lifes.text = "00"
	else:
		$Panel/Lifes.text = String(lifes)

func _on_NewLevel_body_entered(body):
	if body.get_name() == "Player":
		if (get_tree().get_current_scene().get_name() == "Level1"):
			$Message.text = "Super! Du hast das Level bestanden. Bereite sich aufs zweite Level vor."
			$Message.show()
			$DarkerDisplay.show()
			yield(get_tree().create_timer(3.0), "timeout")
			get_tree().change_scene("res://Scenes/02_Level2.tscn")
		elif (get_tree().get_current_scene().get_name() == "Level2"):
			$Message.text = "Super! Du hast das Level bestanden. Bereite sich aufs dritte Level vor."
			$Message.show()
			$DarkerDisplay.show()
			yield(get_tree().create_timer(3.0), "timeout")
			get_tree().change_scene("res://Scenes/03_Level3.tscn")


func _on_Player_shooting():
	#currentCollectables -= 5 
	available_projectile -= 1
	if available_projectile < 10:
		$Panel/Projectiles.text = "0" + String(available_projectile)
	else:
		$Panel/Projectiles.text = String(available_projectile)

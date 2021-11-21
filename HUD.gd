extends CanvasLayer

var collectables = 0

func _ready():
	if collectables < 10:
		$Collectables.text = "0" + String(collectables)
	else:
		$Collectables.text = String(collectables)
	$Message.hide()

func _physics_process(delta):
	if collectables == 5:
		$Message.show()
		yield(get_tree().create_timer(2.0), "timeout")
		get_tree().change_scene("res://01_LevelA.tscn")

func _on_collectable_collected():
	collectables = collectables + 1
	if collectables < 10:
		$Collectables.text = "0" + String(collectables)
	else:
		$Collectables.text = String(collectables)
	

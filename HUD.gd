extends CanvasLayer

var collectables = 0

func _ready():
	$Collectables.text = String(collectables)

func _physics_process(delta):
	if collectables == 3:
		get_tree().change_scene("res://01_LevelA.tscn")

func _on_collectable_collected():
	collectables = collectables + 1
	$Collectables.text = String(collectables)

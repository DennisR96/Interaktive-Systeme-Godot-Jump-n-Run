extends Node



func _ready():
	if (get_tree().get_current_scene().get_name() == "Level1"):
		$Platform/MovingPlatform/AnimationPlayer2.play("LR")
		$Platform/MovingPlatform2/AnimationPlayer2.play("LR")
		$Platform/MovingPlatform3/AnimationPlayer2.play("LR")
		$Platform/MovingPlatform4/AnimationPlayer2.play("LR")
	elif (get_tree().get_current_scene().get_name() == "Level2"):
		$Platform/MovingPlatform/AnimationPlayer2.play("LR")
		$Platform/MovingPlatform2/AnimationPlayer2.play("LR")
	elif (get_tree().get_current_scene().get_name() == "Level3"):
		$Platform/MovingPlatform/AnimationPlayer2.play("LR")

func _on_Area2D_body_entered(body):
	if (body.get_name() == "Player"):
		body.ouchFallzone()
		
func _physics_process(delta):
	if Input.is_action_just_pressed("ui_cancel"):
		get_tree().change_scene("res://00_Menu.tscn")

func _on_OuchWallSpikes_body_entered(body):
	if (body.get_name() == "Player"):
		body.ouchWallSpikes()

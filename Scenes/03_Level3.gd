extends Node2D

func _ready():
	pass # Replace with function body.

func _physics_process(delta):
	if not is_instance_valid($Game/Enemies/Enemy_Final):
		$Game/Princess.visible = true

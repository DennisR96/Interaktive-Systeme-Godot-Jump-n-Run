extends Area2D

export var speed = 100
export var direction = 1

func _ready():
	set_as_toplevel(true)

func _process(delta):
	position += (Vector2.RIGHT*speed*direction).rotated(rotation) * delta
func _physics_process(delta):
	yield(get_tree().create_timer(0.01),"timeout")
	$Sprite.frame = 1
	set_physics_process(false)


# Delete when screen is exited
func _on_VisibilityNotifier2D_screen_exited():
	queue_free()


func _on_Area2D_body_entered(body):
	print(body.name)
	if body.name == "Player":
		return 0
	if "Enemy" in body.name:
		body.dead()
	queue_free()
	
	
	
	
	
func _on_Enemy_body_entered(body):
	print("Enemy")

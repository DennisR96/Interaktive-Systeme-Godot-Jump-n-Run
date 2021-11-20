extends Area2D

const SPEED = 100
var velocity = Vector2()

func _ready():
	pass
	
func _physics_process(delta):
	velocity.x = SPEED * delta
	translate(velocity)
	$AnimatedSprite.play("shoot")



func _on_VisibilityNotifier2D_screen_exited():
	# Projectile entfernen wenn es aus dem Screen geht
	queue_free()

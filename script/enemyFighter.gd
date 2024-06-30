extends CharacterBody2D

var speed : int = 300
var direction : Vector2 =  Vector2(0,1)

# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#direction * speed * delta
	velocity = direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body):
		queue_free()



func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()

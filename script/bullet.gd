extends CharacterBody2D

var speed : int = 600
var direction : int = -1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass
	
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_y(direction * speed * delta)


func _on_visible_notifier_screen_exited():
	queue_free()

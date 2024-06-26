extends Node2D

var speed : int = 300
var direction : int = 1

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	move_local_y(direction * speed * delta)


func _on_visible_on_screen_enabler_2d_screen_exited():
	queue_free()


func _on_area_2d_body_entered(body):
	queue_free()

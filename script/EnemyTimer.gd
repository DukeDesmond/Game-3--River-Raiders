extends Timer


# Called when the node enters the scene tree for the first time.
@onready var path_follow_2d = $"../PathFollow2D"

var enemyFighter = preload("res://scenes/enemyFighter.tscn")
var enemyFrigate = preload("res://scenes/enemyFrigate.tscn")
var instance
func _ready():
	randomize()


func _on_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	path_follow_2d.h_offset = rng.randi_range(0,300)
	
	if (path_follow_2d.h_offset <= 50) or (path_follow_2d.h_offset >=250):
		instance = enemyFrigate.instantiate()
		instance.global_position = path_follow_2d.global_position
		add_child(instance)
	else:
		instance = enemyFighter.instantiate()
		instance.global_position = path_follow_2d.global_position
		add_child(instance)
	
	

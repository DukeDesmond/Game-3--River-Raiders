extends Timer


# Called when the node enters the scene tree for the first time.
@onready var path_follow_2d = $"../PathFollow2D"

var enemy = preload("res://scenes/enemyFighter.tscn")
func _ready():
	randomize()


func _on_timeout():
	var rng = RandomNumberGenerator.new()
	rng.randomize()
	path_follow_2d.h_offset = rng.randi_range(0,300)
	var instance = enemy.instantiate()
	instance.global_position = path_follow_2d.global_position
	add_child(instance)

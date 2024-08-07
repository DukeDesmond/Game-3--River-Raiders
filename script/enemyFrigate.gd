extends CharacterBody2D

var speed : int = 200
var direction : Vector2 =  Vector2(0,1)
var life: int = 3
var bullet = preload("res://scenes/enemy_bullet.tscn")
var muzzlePosition

@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
@onready var area2dCollisison = $Area2D/CollisionShape2D
@onready var charactercollision = $CollisionShape2D
@onready var muzzle = $Muzzle
@onready var reload_timer = $reloadTimer
@onready var audio_stream_player_2d = $AudioStreamPlayer2D


# Called when the node enters the scene tree for the first ti$menuTimer.
func _ready():
	muzzlePosition = muzzle.position

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#direction * speed * delta
	velocity = direction * speed
	move_and_slide()
	#aim()

func damage():
	animation_player.play("hit_flash")
	if life != 0:
		life -= 1
	elif life == 0:
		life -= 1
		direction =  Vector2(0,0)
		area2dCollisison.disabled = true
		charactercollision.disabled = true
		get_tree().call_group("score", "add_score500")
		audio_stream_player_2d.play()
		animated_sprite_2d.play("death")

func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()

func _on_animated_sprite_2d_animation_finished():	
	if animated_sprite_2d.animation == "death":
		queue_free()
		
func _on_area_2d_body_entered(body):
	if body.has_method("tookDamage"):
		body.tookDamage()
		queue_free()

func shoot():
	var bulletInstance = bullet.instantiate() as Node2D
	bulletInstance.global_position = muzzle.global_position
	get_parent().add_child(bulletInstance)

func _on_reload_timer_timeout():
	shoot()

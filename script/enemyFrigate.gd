extends CharacterBody2D

var speed : int = 200
var direction : Vector2 =  Vector2(0,1)
@onready var animation_player = $AnimationPlayer
@onready var animated_sprite_2d = $AnimatedSprite2D
var life: int = 5
@onready var area2dCollisison = $Area2D/CollisionShape2D
@onready var charactercollision = $CollisionShape2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _physics_process(delta):
	#direction * speed * delta
	velocity = direction * speed
	move_and_slide()


func _on_area_2d_body_entered(body):
	animation_player.play("hit_flash")
	if life != 0:
		life -= 1
	else:
		area2dCollisison.disabled = true
		charactercollision.disabled = true
		animated_sprite_2d.play("death")
		
	


func _on_visible_on_screen_notifier_2d_screen_exited():
		queue_free()



func _on_animated_sprite_2d_animation_finished():	
	if animated_sprite_2d.animation == "death":
		queue_free()

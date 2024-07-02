extends StaticBody2D



@onready var main_ship = $mainShip
@onready var weapons = $mainShip/weapons
@onready var engine = $mainShip/engine
@onready var engine_effect = $mainShip/engine/engineEffect
@onready var animation_player = $AnimationPlayer
@onready var muzzle1 :Marker2D = $mainShip/weapons/Muzzle1
@onready var muzzle2 :Marker2D = $mainShip/weapons/Muzzle2
@onready var reload_timer = $reloadTimer

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var reload : bool = false
var muzzle1Position
var muzzle2Position
var velocity : Vector2 = Vector2(0,0)
var speed= 400.0
var bullet = preload("res://scenes/bullet.tscn")
var life: int = 4


func _ready():
	muzzle1Position = muzzle1.position
	muzzle2Position = muzzle2.position

func _physics_process(delta):
	# Add the gravity.
	#if not is_on_floor():
	#	velocity.y += gravity * delta

	# Handle jump.
	if Input.is_action_pressed("ui_accept") and reload == false:
		playerShoot()
		reload = true
		reload_timer.start(0.1)

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * speed * delta
	else:
		velocity.x = move_toward(velocity.x, 0, speed)

	move_and_collide(velocity)

func playerShoot ():
	var bulletInstance1 = bullet.instantiate() as Node2D
	var bulletInstance2 = bullet.instantiate() as Node2D
	bulletInstance1.global_position = muzzle1.global_position
	bulletInstance2.global_position = muzzle2.global_position
	 
	get_parent().add_child(bulletInstance2)


func _on_reload_timer_timeout():
	reload = false

func tookDamage():
	if animation_player.assigned_animation == "immunity_frames":
		pass
		
	elif life == 4:
		life -= 1
		main_ship.play("damage1")
		animation_player.play("immunity_frames")
		
		
	elif life == 3:
		life -= 1
		main_ship.play("damage2")
		animation_player.play("immunity_frames")
		
	elif life == 2:
		life -= 1
		main_ship.play("damage3")
		animation_player.play("immunity_frames")
		
	else:
		life -= 1
		weapons.visible = false
		engine.visible = false
		engine_effect.visible = false
		speed = 0
		main_ship.play("death")


func _on_main_ship_animation_finished():
	if main_ship.animation == "death":
		queue_free()


func _on_animation_player_animation_finished(anim_name):
	animation_player.play('RESET')

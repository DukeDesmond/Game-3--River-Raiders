extends CharacterBody2D


const SPEED = 400.0
var bullet = preload("res://scenes/bullet.tscn")

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
@onready var muzzle1 :Marker2D = $mainShip/weapons/Muzzle1
@onready var muzzle2 :Marker2D = $mainShip/weapons/Muzzle2
@onready var reload_timer = $reloadTimer
var reload : bool = false
var muzzle1Position
var muzzle2Position



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
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()

func playerShoot ():
	var bulletInstance1 = bullet.instantiate() as Node2D
	var bulletInstance2 = bullet.instantiate() as Node2D
	bulletInstance1.global_position = muzzle1.global_position
	bulletInstance2.global_position = muzzle2.global_position
	get_parent().add_child(bulletInstance1)
	get_parent().add_child(bulletInstance2)


func _on_reload_timer_timeout():
	reload = false

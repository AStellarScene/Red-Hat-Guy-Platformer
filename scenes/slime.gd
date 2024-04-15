extends CharacterBody2D

const SPEED = 100
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

var direction = -1
var special = false

func _ready():
	pass

func _physics_process(delta):
	apply_gravity(delta)
	update_horizontal_movement()
	move_slide()

func update_horizontal_movement():
	if is_on_wall():
		direction = direction * -1

func apply_gravity(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

func move_slide():
	velocity.x = SPEED * direction
	velocity.y += 20 
	move_and_slide()

extends CharacterBody2D


const SPEED = 300.0
const JUMP_VELOCITY = -700

var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

@onready var label_lives = $"Label-Lives"
@onready var timer = $Area2D/Timer

var lives = 3
var hurt = false

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += gravity * delta

	if Input.is_action_just_pressed("ui_accept") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var direction = Input.get_axis("ui_left", "ui_right")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	if hurt == true:
		velocity.x = -1000
		velocity.y = -1000

	move_and_slide()


func _on_area_2d_area_entered(area):
	if area.is_in_group("hurt"):
		print("Hurt!")
		if lives > 0:
			lives = lives - 1
			timer.start()
			hurt = true
			label_lives.text = str(lives)
		else:
			position = Vector2(0, 0)
			lives = 3
			label_lives.text = str(lives)
	if area.is_in_group("floor"):
		position = Vector2(0, 0)
		lives = 3
		label_lives.text = str(lives)

func _on_timer_timeout():
	hurt = false
	timer.stop()

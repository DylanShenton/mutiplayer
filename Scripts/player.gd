extends CharacterBody2D
var gravity = 40
var since_floor = 0
var jump_velocity = -500
var speed = 300
var slow = 15
var pushing = false
func _physics_process(delta):
	if not Global.pause:
		if not is_on_floor():
			since_floor += 1
			velocity.y+=gravity
			$anim.play("Fall")
		else:
			since_floor = 0
		if velocity == Vector2.ZERO and is_on_floor():
			$anim.play("Idle")
		if Input.is_action_pressed("w"):
			if is_on_floor() or since_floor<10:
				since_floor = 10
				velocity.y = jump_velocity
		if Input.is_action_pressed("a"):
			velocity.x = -speed
			if is_on_floor():
				$anim.play("Run")
				for i in $Sprites.get_children():
					i.flip_h = false
		if Input.is_action_just_released("a"):
			$anim.play("Idle")
		if Input.is_action_pressed("d"):
			velocity.x = speed
			if is_on_floor():
				$anim.play("Run")
				for i in $Sprites.get_children():
					i.flip_h = true
		if Input.is_action_just_released("d"):
			$anim.play("Idle")
		velocity = Vector2(move_toward(velocity.x,0,slow),move_toward(velocity.y,0,slow))
		move_and_slide()

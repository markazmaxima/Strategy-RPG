extends CharacterBody2D

@onready var get_damage = $"/root/Global"
const speed = 2000
const jump_value = -4800
const accel = 100
const friction = 140
const gravity = 240
const max_jump = 2
var curr_jump = 1

func _physics_process(_delta):
	get_damage.player_position = position
	
	$DebugLook.look_at(get_global_mouse_position()) # precise mouse position usage
	
	var input_dir: Vector2 = input()
	
	if input_dir != Vector2.ZERO:
		var posX = input_dir.x
		accelerate(input_dir)
		if posX == -1:
			animate_left()
		else:
			animate_right()
	else:
		add_friction()
		#play idle animation
	player_movement()
	jump()
	
func input() -> Vector2:
	var input_dir = Vector2.ZERO

	input_dir.x = Input.get_axis("move_left", "move_right")
	input_dir = input_dir.normalized()
	return input_dir
	
func accelerate(direction):
	velocity = velocity.move_toward(speed * direction, accel)
	
func add_friction():
	velocity = velocity.move_toward(Vector2.ZERO, friction)
	
func player_movement():
	move_and_slide()
	
func jump():
	if Input.is_action_just_pressed("move_jump"):
		if curr_jump < max_jump:
			velocity.y = jump_value
			curr_jump += 1
	else:
		velocity.y += gravity
			
	if is_on_floor():
		curr_jump = 1
	
func animate_left():
	$sprite.flip_h = true
	
func animate_right():
	$sprite.flip_h = false
